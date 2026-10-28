#!/usr/bin/env node
'use strict'
// Inventory of the bus stops mapped in OpenStreetMap inside the Arequipa bounding box
// (trufi-association/trufi-arequipa#40). Queries Overpass for every bus-stop node, classifies
// each one by what the mappers recorded on it, and writes stops-review/stops-review.csv and
// stops-review/stops-review.geojson plus a summary on stdout. Plain Node (>= 20), no dependencies.
// The output folder is deliberately not out/: the GTFS builder deletes out/ on every run.
//
//   node tools/stops-review.js                 query Overpass, write stops-review/, print the summary
//   node tools/stops-review.js --from f.json   same, from a saved Overpass JSON (offline)
//   node tools/stops-review.js --raw f.json    also save the raw Overpass response
//   node tools/stops-review.js --out <dir>     write the files somewhere else
//   OVERPASS_URL=https://.../api/interpreter   use that endpoint only (e.g. a local instance)

const fs = require('fs')
const path = require('path')
const { parseArgs } = require('util')
const bounds = require('../bbox')

// www.overpass-api.de answers 502 "at capacity" under load and asks for exponential backoff;
// overpass.private.coffee is the public mirror formerly known as overpass.kumi.systems (same
// server, renamed; see the "Public Overpass API instances" table on the OSM wiki).
const DEFAULT_OVERPASS_URLS = [
    'https://overpass-api.de/api/interpreter',
    'https://overpass.private.coffee/api/interpreter',
]
const USER_AGENT = 'trufi-arequipa stops-review (+https://github.com/trufi-association/trufi-arequipa)'

// Class names are the ones used in issue #40 and in the municipality's own inventory.
const CLASSES = Object.freeze({
    INFRA: 'infraestructura',
    SIGNED: 'señalizada',
    BARE: 'sin señal ni infraestructura',
    UNKNOWN: 'sin clasificar',
})
const CLASS_ORDER = [CLASSES.INFRA, CLASSES.SIGNED, CLASSES.BARE, CLASSES.UNKNOWN]

const CSV_COLUMNS = [
    'osm_id', 'osm_type', 'lat', 'lon', 'class', 'name', 'highway', 'public_transport', 'bus',
    'shelter', 'bench', 'sign', 'traffic_sign', 'covered', 'lit', 'bin',
    'operator', 'network', 'route_relations', 'routes', 'osm_url',
]

function bboxString(b) {
    return `${b.south},${b.west},${b.north},${b.east}`
}

// Every object that can stand for a bus stop in the bbox: the bus-stop nodes, the stop positions
// that carry no mode at all (the mappers left bus=* off two of them; rail ones carry train=yes),
// and the platforms mapped as ways (a linear waiting area; placed at their centre), then the
// route relations that list any of them as a member (so we can tell which stops are wired to a line).
function buildQuery(b = bounds) {
    const bbox = bboxString(b)
    return [
        '[out:json][timeout:120];',
        '(',
        `  node["highway"="bus_stop"](${bbox});`,
        `  node["public_transport"="platform"]["bus"="yes"](${bbox});`,
        `  node["public_transport"="stop_position"]["bus"="yes"](${bbox});`,
        `  node["public_transport"="stop_position"][!"bus"][!"train"][!"tram"][!"subway"][!"light_rail"][!"ferry"][!"railway"](${bbox});`,
        `  way["public_transport"="platform"]["bus"="yes"](${bbox});`,
        ')->.stops;',
        '.stops out body center;',
        '(rel(bn.stops)["type"="route"]; rel(bw.stops)["type"="route"];);',
        'out body;',
    ].join('\n')
}

// Classification rules (documented in README.md, "Stops review"):
//   infraestructura  - something to sit under or on: shelter=yes|separate, bench=yes|separate,
//                      amenity=shelter, shelter_type=public_transport or covered=yes
//   señalizada       - no furniture, but a sign: sign=yes (the key used in Arequipa) or traffic_sign=*
//   sin señal ni infraestructura - the mapper recorded the absence of both (sign=no and
//                      shelter=no or bench=no): a boarding place with nothing built on it
//   sin clasificar   - no inventory tags at all (typically a bare highway=bus_stop): not surveyed yet
// Infrastructure wins over the sign: a shelter with a sign counts once, as infrastructure.
const PRESENT = new Set(['yes', 'separate'])

function hasInfrastructure(tags) {
    return PRESENT.has(tags.shelter)
        || PRESENT.has(tags.bench)
        || tags.amenity === 'shelter'
        || tags.shelter_type === 'public_transport'
        || tags.covered === 'yes'
}

function isSigned(tags) {
    return tags.sign === 'yes' || (typeof tags.traffic_sign === 'string' && tags.traffic_sign !== '')
}

function classify(tags = {}) {
    if (hasInfrastructure(tags)) return CLASSES.INFRA
    if (isSigned(tags)) return CLASSES.SIGNED
    if (tags.sign === 'no' && (tags.shelter === 'no' || tags.bench === 'no')) return CLASSES.BARE
    return CLASSES.UNKNOWN
}

const STOP_TYPES = new Set(['node', 'way'])

// "node/123" or "way/456" -> route relations (type=route) that list that object as a member
function indexRouteMembership(elements) {
    const byMember = new Map()
    for (const el of elements) {
        if (el.type !== 'relation') continue
        const tags = el.tags || {}
        for (const m of el.members || []) {
            if (!STOP_TYPES.has(m.type)) continue
            const key = `${m.type}/${m.ref}`
            if (!byMember.has(key)) byMember.set(key, [])
            byMember.get(key).push({ id: el.id, ref: tags.ref, name: tags.name, route: tags.route, role: m.role })
        }
    }
    return byMember
}

// A node has lat/lon; a way answers with its centre (out center).
function coordinatesOf(el) {
    const point = el.type === 'way' ? el.center : el
    return point && typeof point.lat === 'number' && typeof point.lon === 'number'
        ? { lat: point.lat, lon: point.lon }
        : { lat: undefined, lon: undefined }
}

function buildRows(elements) {
    const membership = indexRouteMembership(elements)
    return elements
        .filter((el) => STOP_TYPES.has(el.type))
        .map((n) => {
            const tags = n.tags || {}
            const routes = membership.get(`${n.type}/${n.id}`) || []
            const { lat, lon } = coordinatesOf(n)
            return {
                osm_id: n.id,
                osm_type: n.type,
                lat,
                lon,
                class: classify(tags),
                name: tags.name || '',
                highway: tags.highway || '',
                public_transport: tags.public_transport || '',
                bus: tags.bus || '',
                shelter: tags.shelter || '',
                bench: tags.bench || '',
                sign: tags.sign || '',
                traffic_sign: tags.traffic_sign || '',
                covered: tags.covered || '',
                lit: tags.lit || '',
                bin: tags.bin || '',
                operator: tags.operator || '',
                network: tags.network || '',
                route_relations: routes.length,
                routes: routes.map((r) => r.ref || r.name || String(r.id)).join('; '),
                osm_url: `https://www.openstreetmap.org/${n.type}/${n.id}`,
            }
        })
        .sort((a, b) => a.osm_type.localeCompare(b.osm_type) || a.osm_id - b.osm_id)   // nodes, then ways
}

// RFC 4180: quote a field when it carries a separator, a quote or a line break; double the quotes.
function csvField(value) {
    const s = value === undefined || value === null ? '' : String(value)
    return /[",\r\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s
}

function toCsv(rows) {
    const lines = [CSV_COLUMNS.join(',')]
    for (const row of rows) lines.push(CSV_COLUMNS.map((c) => csvField(row[c])).join(','))
    return lines.join('\n') + '\n'
}

// One feature per line: readable diffs when the inventory is regenerated.
function toGeoJson(rows, meta = {}) {
    const features = rows.map((row) => {
        const { lat, lon, ...properties } = row
        return JSON.stringify({
            type: 'Feature',
            id: `${row.osm_type}/${row.osm_id}`,   // node and way ids are separate namespaces in OSM
            geometry: lat === undefined ? null : { type: 'Point', coordinates: [lon, lat] },
            properties,
        })
    })
    const head = JSON.stringify({ type: 'FeatureCollection', ...meta }).slice(0, -1)
    return `${head}, "features": [\n${features.join(',\n')}\n]}\n`
}

function countBy(rows, key) {
    const counts = new Map()
    for (const row of rows) {
        const k = row[key] || ''
        if (!counts.has(k)) counts.set(k, { total: 0, classes: Object.fromEntries(CLASS_ORDER.map((c) => [c, 0])) })
        const entry = counts.get(k)
        entry.total += 1
        entry.classes[row.class] += 1
    }
    return [...counts.entries()]
        .map(([value, entry]) => ({ value, ...entry }))
        .sort((a, b) => b.total - a.total || a.value.localeCompare(b.value))
}

function summarize(rows) {
    const byClass = Object.fromEntries(CLASS_ORDER.map((c) => [c, 0]))
    for (const row of rows) byClass[row.class] += 1
    return {
        total: rows.length,
        byType: {
            node: rows.filter((r) => r.osm_type === 'node').length,
            way: rows.filter((r) => r.osm_type === 'way').length,
        },
        byClass,
        byOperator: countBy(rows, 'operator'),
        byNetwork: countBy(rows, 'network'),
        inRouteRelations: rows.filter((r) => r.route_relations > 0).length,
        dataQuality: {
            withoutPublicTransport: rows.filter((r) => !r.public_transport).length,
            unexpectedPublicTransport: rows.filter((r) => r.public_transport && !['platform', 'stop_position'].includes(r.public_transport)).length,
            stopPositionWithoutMode: rows.filter((r) => r.public_transport === 'stop_position' && !r.bus).length,
            busNo: rows.filter((r) => r.bus === 'no').length,
            withoutName: rows.filter((r) => !r.name).length,
        },
    }
}

function pct(part, total) {
    return total ? `${((100 * part) / total).toFixed(1)} %` : '-'
}

function groupTable(title, groups, total) {
    const lines = [`| ${title} | total | ${CLASS_ORDER.join(' | ')} |`, `|---|---:|${CLASS_ORDER.map(() => '---:').join('|')}|`]
    for (const g of groups) {
        lines.push(`| ${g.value || `(sin ${title})`} | ${g.total} | ${CLASS_ORDER.map((c) => g.classes[c]).join(' | ')} |`)
    }
    lines.push(`| **total** | **${total}** | ${CLASS_ORDER.map(() => '').join(' | ')} |`)
    return lines.join('\n')
}

function formatSummary(summary, meta = {}) {
    const out = []
    out.push(`# Paradas de bus en OSM — Arequipa (${meta.osmBase || 'fecha desconocida'})`)
    out.push('')
    out.push(`bbox ${bboxString(bounds)} · fuente ${meta.source || 'Overpass'} · ${summary.byType.node} nodos + ${summary.byType.way} ways (plataformas lineales, en su centro)`)
    out.push('')
    out.push('| clase | paradas | % |')
    out.push('|---|---:|---:|')
    for (const c of CLASS_ORDER) out.push(`| ${c} | ${summary.byClass[c]} | ${pct(summary.byClass[c], summary.total)} |`)
    out.push(`| **total** | **${summary.total}** | 100 % |`)
    out.push('')
    out.push(`Miembros de alguna relación de ruta (type=route): **${summary.inRouteRelations}** de ${summary.total}.`)
    out.push('')
    out.push(groupTable('operator', summary.byOperator, summary.total))
    out.push('')
    out.push(groupTable('network', summary.byNetwork, summary.total))
    out.push('')
    const dq = summary.dataQuality
    out.push('Calidad de datos: '
        + `${dq.withoutPublicTransport} sin public_transport, `
        + `${dq.unexpectedPublicTransport} con public_transport distinto de platform/stop_position, `
        + `${dq.stopPositionWithoutMode} stop_position sin modo (sin bus=*), `
        + `${dq.busNo} con bus=no, ${dq.withoutName} sin name.`)
    return out.join('\n') + '\n'
}

class OverpassQueryError extends Error {}

function excerpt(text) {
    return String(text).replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim().slice(0, 200)
}

// POSTs the query to each endpoint in turn; on 429/5xx, timeouts, network errors or non-JSON
// bodies it waits with exponential backoff and tries again. HTTP 400 is a query error: fatal.
async function fetchOverpass(query, {
    urls = DEFAULT_OVERPASS_URLS,
    attempts = 5,
    timeoutMs = 180_000,
    baseDelayMs = 15_000,
    maxDelayMs = 120_000,
    fetchImpl = globalThis.fetch,
    sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms)),
    log = (msg) => console.error(msg),
} = {}) {
    if (!urls.length) throw new Error('No Overpass endpoint configured')
    let delay = baseDelayMs
    let lastError
    for (let attempt = 1; attempt <= attempts; attempt++) {
        for (const url of urls) {
            try {
                log(`[overpass] attempt ${attempt}/${attempts}: ${url}`)
                const response = await fetchImpl(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'User-Agent': USER_AGENT,
                        'Accept': 'application/json',
                    },
                    body: `data=${encodeURIComponent(query)}`,
                    signal: AbortSignal.timeout(timeoutMs),
                })
                const text = await response.text()
                if (response.status === 400) throw new OverpassQueryError(`Overpass rejected the query (HTTP 400): ${excerpt(text)}`)
                if (!response.ok) throw new Error(`HTTP ${response.status} from ${url}: ${excerpt(text)}`)
                let json
                try {
                    json = JSON.parse(text)
                } catch {
                    throw new Error(`non-JSON response (HTTP ${response.status}) from ${url}: ${excerpt(text)}`)
                }
                if (typeof json.remark === 'string' && /runtime error/i.test(json.remark)) throw new Error(`Overpass remark from ${url}: ${json.remark}`)
                if (!Array.isArray(json.elements)) throw new Error(`response without elements from ${url}`)
                return json
            } catch (err) {
                if (err instanceof OverpassQueryError) throw err
                lastError = err
                log(`[overpass] ${err.name === 'TimeoutError' ? `timeout after ${timeoutMs / 1000}s on ${url}` : err.message}`)
            }
        }
        if (attempt < attempts) {
            log(`[overpass] waiting ${delay / 1000}s before retrying`)
            await sleep(delay)
            delay = Math.min(delay * 2, maxDelayMs)
        }
    }
    throw new Error(`Overpass failed after ${attempts} attempt(s) on ${urls.length} endpoint(s): ${lastError && lastError.message}`)
}

function endpointsFromEnv(env = process.env) {
    return env.OVERPASS_URL ? [env.OVERPASS_URL] : DEFAULT_OVERPASS_URLS
}

// Public mirrors can lag the live OSM database by months (overpass.private.coffee served a
// 2026-06-01 base on 2026-10-28): the age of osm3s.timestamp_osm_base is part of the result.
const STALE_AFTER_DAYS = 2

function baseAgeDays(osmBase, now = Date.now()) {
    const t = Date.parse(osmBase)
    return Number.isNaN(t) ? null : (now - t) / 86_400_000
}

async function run(argv, { env = process.env, write = (s) => process.stdout.write(s), warn = (s) => console.error(s), now = Date.now(), fetchImpl } = {}) {
    const { values: args } = parseArgs({
        args: argv,
        options: { from: { type: 'string' }, raw: { type: 'string' }, out: { type: 'string' } },
    })
    const query = buildQuery(bounds)
    let data
    let source
    if (args.from) {
        data = JSON.parse(fs.readFileSync(args.from, 'utf8'))
        source = args.from
    } else {
        const urls = endpointsFromEnv(env)
        data = await fetchOverpass(query, { urls, ...(fetchImpl ? { fetchImpl } : {}) })
        source = 'Overpass'
        if (args.raw) fs.writeFileSync(args.raw, JSON.stringify(data))
    }
    const osmBase = data.osm3s && data.osm3s.timestamp_osm_base
    const ageDays = baseAgeDays(osmBase, now)
    if (ageDays === null) {
        warn('[overpass] the response carries no osm3s.timestamp_osm_base: cannot tell how old the data is')
    } else if (ageDays > STALE_AFTER_DAYS) {
        warn(`[overpass] WARNING: the OSM data is ${Math.floor(ageDays)} days old (base ${osmBase}): this endpoint lags the live database. `
            + 'Rerun later or with OVERPASS_URL=https://overpass-api.de/api/interpreter if you need current data.')
    }
    const rows = buildRows(data.elements)
    const outDir = args.out || path.join(__dirname, '..', 'stops-review')
    fs.mkdirSync(outDir, { recursive: true })
    const csvPath = path.join(outDir, 'stops-review.csv')
    const geojsonPath = path.join(outDir, 'stops-review.geojson')
    fs.writeFileSync(csvPath, toCsv(rows))
    fs.writeFileSync(geojsonPath, toGeoJson(rows, { osm_base: osmBase, bbox: bboxString(bounds), generated: new Date().toISOString() }))
    const summary = summarize(rows)
    write(formatSummary(summary, { osmBase, source }))
    write(`\nEscrito ${csvPath} y ${geojsonPath}\n`)
    return { rows, summary, csvPath, geojsonPath }
}

if (require.main === module) {
    run(process.argv.slice(2)).catch((err) => {
        console.error(err.message)
        process.exitCode = 1   // a failed run (e.g. Overpass at capacity) must not look like a success
    })
}

module.exports = {
    CLASSES, CLASS_ORDER, CSV_COLUMNS, DEFAULT_OVERPASS_URLS, OverpassQueryError,
    buildQuery, classify, indexRouteMembership, buildRows, toCsv, toGeoJson,
    summarize, formatSummary, fetchOverpass, endpointsFromEnv, baseAgeDays, STALE_AFTER_DAYS, run,
}
