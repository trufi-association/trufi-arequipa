'use strict'
const test = require('node:test')
const assert = require('node:assert/strict')
const fs = require('fs')
const os = require('os')
const path = require('path')

const bounds = require('../bbox')
const review = require('./stops-review')
const { CLASSES, classify, buildQuery, buildRows, toCsv, toGeoJson, summarize, formatSummary, fetchOverpass, endpointsFromEnv, run } = review

// 11 real nodes and 1 real way of the Arequipa inventory (as in OSM on 2026-10-28) plus two
// synthetic route relations (ids 9000000xx) that reference some of them.
const FIXTURE = path.join(__dirname, 'fixtures', 'overpass-sample.json')
const fixture = () => JSON.parse(fs.readFileSync(FIXTURE, 'utf8'))

test('bbox: shared with index.js and well formed', () => {
    assert.ok(bounds.south < bounds.north && bounds.west < bounds.east)
    const indexSource = fs.readFileSync(path.join(__dirname, '..', 'index.js'), 'utf8')
    assert.match(indexSource, /require\('\.\/bbox'\)/, 'index.js must take the bbox from bbox.js')
})

test('buildQuery: stop nodes, mode-less stop positions and platform ways in the bbox, then the relations that reference them', () => {
    const q = buildQuery({ south: -1, west: -2, north: 1, east: 2 })
    assert.match(q, /^\[out:json\]\[timeout:\d+\];/)
    assert.match(q, /node\["highway"="bus_stop"\]\(-1,-2,1,2\);/)
    assert.match(q, /node\["public_transport"="platform"\]\["bus"="yes"\]\(-1,-2,1,2\);/)
    assert.match(q, /node\["public_transport"="stop_position"\]\["bus"="yes"\]\(-1,-2,1,2\);/)
    assert.match(q, /node\["public_transport"="stop_position"\]\[!"bus"\]\[!"train"\]\[!"tram"\]\[!"subway"\]\[!"light_rail"\]\[!"ferry"\]\[!"railway"\]\(-1,-2,1,2\);/)
    assert.match(q, /way\["public_transport"="platform"\]\["bus"="yes"\]\(-1,-2,1,2\);/)
    assert.match(q, /\)->\.stops;\n\.stops out body center;\n\(rel\(bn\.stops\)\["type"="route"\]; rel\(bw\.stops\)\["type"="route"\];\);\nout body;$/)
})

test('classify: infrastructure tags win, in any combination', () => {
    assert.equal(classify({ highway: 'bus_stop', shelter: 'yes', bench: 'yes', sign: 'yes' }), CLASSES.INFRA)
    assert.equal(classify({ highway: 'bus_stop', shelter: 'yes', bench: 'yes', sign: 'no' }), CLASSES.INFRA)
    assert.equal(classify({ highway: 'bus_stop', bench: 'yes' }), CLASSES.INFRA)
    assert.equal(classify({ highway: 'bus_stop', shelter: 'separate' }), CLASSES.INFRA)
    assert.equal(classify({ highway: 'bus_stop', bench: 'yes', covered: 'yes' }), CLASSES.INFRA)
    assert.equal(classify({ highway: 'bus_stop', covered: 'yes' }), CLASSES.INFRA)
    assert.equal(classify({ amenity: 'shelter', shelter_type: 'public_transport' }), CLASSES.INFRA)
    assert.equal(classify({ public_transport: 'platform', bus: 'yes', shelter_type: 'public_transport' }), CLASSES.INFRA)
})

test('classify: a sign without furniture is "señalizada"', () => {
    assert.equal(classify({ highway: 'bus_stop', sign: 'yes' }), CLASSES.SIGNED)
    assert.equal(classify({ highway: 'bus_stop', shelter: 'no', bench: 'no', sign: 'yes' }), CLASSES.SIGNED)
    assert.equal(classify({ highway: 'bus_stop', traffic_sign: 'PE:bus_stop' }), CLASSES.SIGNED)
    assert.equal(classify({ public_transport: 'platform', bus: 'yes', traffic_sign: 'bus_stop', shelter: 'no' }), CLASSES.SIGNED)
})

test('classify: recorded absence of sign and furniture is its own class', () => {
    assert.equal(classify({ highway: 'bus_stop', shelter: 'no', bench: 'no', sign: 'no' }), CLASSES.BARE)
    assert.equal(classify({ highway: 'bus_stop', bench: 'no', sign: 'no' }), CLASSES.BARE)
    assert.equal(classify({ highway: 'bus_stop', shelter: 'no', sign: 'no' }), CLASSES.BARE)
})

test('classify: without inventory tags the stop is "sin clasificar"', () => {
    assert.equal(classify({ highway: 'bus_stop' }), CLASSES.UNKNOWN)
    assert.equal(classify({ highway: 'bus_stop', public_transport: 'platform', bus: 'yes', name: 'x' }), CLASSES.UNKNOWN)
    assert.equal(classify({ public_transport: 'stop_position', bus: 'yes' }), CLASSES.UNKNOWN)
    assert.equal(classify({ public_transport: 'platform', bus: 'yes', surface: 'asphalt' }), CLASSES.UNKNOWN, 'a platform way with no inventory tags')
    assert.equal(classify({ highway: 'bus_stop', sign: 'no' }), CLASSES.UNKNOWN, 'sign=no alone: furniture not surveyed')
    assert.equal(classify({ highway: 'bus_stop', shelter: 'no', bench: 'no' }), CLASSES.UNKNOWN, 'no sign tag: sign not surveyed')
    assert.equal(classify({ highway: 'bus_stop', covered: 'no', traffic_sign: '' }), CLASSES.UNKNOWN)
    assert.equal(classify({}), CLASSES.UNKNOWN)
    assert.equal(classify(), CLASSES.UNKNOWN)
})

test('buildRows: one row per node and per way, nodes first, with route membership from the relations', () => {
    const rows = buildRows(fixture().elements)
    assert.equal(rows.length, 12)
    assert.deepEqual(rows.map((r) => r.osm_type), [...Array(11).fill('node'), 'way'])
    const nodeIds = rows.filter((r) => r.osm_type === 'node').map((r) => r.osm_id)
    assert.deepEqual(nodeIds, [...nodeIds].sort((a, b) => a - b))
    const byId = Object.fromEntries(rows.map((r) => [r.osm_id, r]))

    assert.equal(byId[4058968456].route_relations, 2)
    assert.equal(byId[4058968456].routes, 'C-3; Línea sin ref: Terminal → Centro', 'ref first, name when there is no ref')
    assert.equal(byId[4058234279].route_relations, 1)
    assert.equal(byId[4058234279].routes, 'C-3')
    assert.equal(byId[1245983469].route_relations, 1, 'a way member counts too')
    assert.equal(byId[1245983469].routes, 'C-3')
    assert.equal(byId[4073461209].route_relations, 0)
    assert.equal(byId[4073461209].routes, '')
    assert.ok(!byId[999999999] && !byId[800000001], 'relation members that are not stops are not rows')

    assert.equal(byId[11195209265].class, CLASSES.INFRA, 'bench + covered')
    assert.equal(byId[4058234279].class, CLASSES.INFRA)
    assert.equal(byId[4058968456].class, CLASSES.SIGNED)
    assert.equal(byId[4073461209].class, CLASSES.INFRA, 'shelter wins over sign=no')
    assert.equal(byId[4197540334].class, CLASSES.UNKNOWN)
    assert.equal(byId[4709194470].class, CLASSES.BARE)
    assert.equal(byId[10882611211].class, CLASSES.UNKNOWN, 'shelter=no, bench=no but no sign tag')
    assert.equal(byId[5777925904].class, CLASSES.UNKNOWN)
    assert.equal(byId[11014310380].class, CLASSES.SIGNED)
    assert.equal(byId[11954185166].class, CLASSES.UNKNOWN, 'stop position without a mode')
    assert.equal(byId[1245983469].class, CLASSES.UNKNOWN, 'platform way without inventory tags')

    assert.equal(byId[1245983469].lat, -16.3525147, 'a way is placed at its centre')
    assert.equal(byId[1245983469].lon, -71.5417543)
    assert.equal(byId[1245983469].osm_url, 'https://www.openstreetmap.org/way/1245983469')
    assert.equal(byId[1245983469].operator, 'TransCayma S.A.C.')
    assert.equal(byId[10866662527].name, 'Grifo "San Fernando", esq. Av. Dolores')
    assert.equal(byId[10866662527].operator, 'Integra Arequipa S.A.C.')
    assert.equal(byId[10866662527].osm_url, 'https://www.openstreetmap.org/node/10866662527')
    assert.equal(byId[5777925904].highway, '')
    assert.equal(byId[5777925904].name, '')
})

test('toCsv: header, one line per row, RFC 4180 quoting, UTF-8 kept', () => {
    const rows = buildRows(fixture().elements)
    const csv = toCsv(rows)
    assert.equal(csv.charCodeAt(0), 0xFEFF, 'UTF-8 BOM so Excel decodes accents on double-click')
    const lines = csv.slice(1).split('\n')
    assert.equal(lines[0], 'osm_id,osm_type,lat,lon,class,name,highway,public_transport,bus,shelter,bench,sign,traffic_sign,covered,lit,bin,operator,network,route_relations,routes,osm_url')
    assert.equal(lines.length, rows.length + 2, 'header + rows + trailing newline')
    assert.equal(lines.at(-1), '')
    const quoted = lines.find((l) => l.startsWith('10866662527,'))
    assert.ok(quoted.includes(',"Grifo ""San Fernando"", esq. Av. Dolores",'), 'comma and quotes force quoting, quotes doubled')
    const signed = lines.find((l) => l.startsWith('4058968456,'))
    assert.equal(signed, '4058968456,node,-16.3982259,-71.5239466,señalizada,Muñoz Najar,bus_stop,stop_position,yes,no,no,yes,,,no,no,,,2,C-3; Línea sin ref: Terminal → Centro,https://www.openstreetmap.org/node/4058968456', 'a semicolon needs no quoting')
    const bare = lines.find((l) => l.startsWith('4709194470,'))
    assert.equal(bare, '4709194470,node,-16.4471296,-71.5282974,sin señal ni infraestructura,,bus_stop,stop_position,yes,no,no,no,,,,,,,0,,https://www.openstreetmap.org/node/4709194470')
    const way = lines.find((l) => l.startsWith('1245983469,'))
    assert.equal(way, '1245983469,way,-16.3525147,-71.5417543,sin clasificar,,,platform,yes,,,,,,,,TransCayma S.A.C.,Sistema Integrado de Transporte (SIT),1,C-3,https://www.openstreetmap.org/way/1245983469')
})

test('toGeoJson: a FeatureCollection of points with [lon, lat] and the row as properties', () => {
    const rows = buildRows(fixture().elements)
    const text = toGeoJson(rows, { osm_base: '2026-10-28T21:40:20Z', bbox: review.geoJsonBbox(bounds) })
    const fc = JSON.parse(text)
    assert.equal(fc.type, 'FeatureCollection')
    assert.equal(fc.osm_base, '2026-10-28T21:40:20Z')
    assert.deepEqual(fc.bbox, [-71.622936, -16.489732, -71.453334, -16.303314], 'RFC 7946 §5: numeric [west, south, east, north]')
    assert.ok(fc.bbox.every((n) => typeof n === 'number'))
    assert.equal(fc.generated, undefined, 'no run timestamp: reruns on unchanged data diff empty')
    assert.equal(fc.features.length, rows.length)
    const f = fc.features.find((x) => x.id === 'node/4058968456')
    assert.deepEqual(f.geometry, { type: 'Point', coordinates: [-71.5239466, -16.3982259] })
    assert.equal(f.properties.class, 'señalizada')
    assert.equal(f.properties.name, 'Muñoz Najar')
    assert.equal(f.properties.route_relations, 2)
    assert.equal(f.properties.lat, undefined, 'coordinates only in the geometry')
    const w = fc.features.find((x) => x.id === 'way/1245983469')
    assert.deepEqual(w.geometry, { type: 'Point', coordinates: [-71.5417543, -16.3525147] }, 'a way becomes a point at its centre')
    assert.equal(w.properties.osm_type, 'way')
    assert.equal(text.split('\n').length, rows.length + 3, 'one feature per line')
})

test('summarize: totals add up per class, type, operator, network and route membership', () => {
    const rows = buildRows(fixture().elements)
    const s = summarize(rows)
    assert.equal(s.total, 12)
    assert.deepEqual(s.byType, { node: 11, way: 1 })
    assert.deepEqual(s.byClass, {
        [CLASSES.INFRA]: 4,
        [CLASSES.SIGNED]: 2,
        [CLASSES.BARE]: 1,
        [CLASSES.UNKNOWN]: 5,
    })
    assert.equal(Object.values(s.byClass).reduce((a, b) => a + b, 0), s.total)
    assert.equal(s.inRouteRelations, 3)
    assert.equal(s.byOperator[0].value, '', 'most stops have no operator in the fixture')
    assert.equal(s.byOperator[0].total, 8)
    const integra = s.byOperator.find((g) => g.value === 'Integra Arequipa S.A.C.')
    assert.deepEqual(integra, { value: 'Integra Arequipa S.A.C.', total: 2, classes: { [CLASSES.INFRA]: 1, [CLASSES.SIGNED]: 0, [CLASSES.BARE]: 0, [CLASSES.UNKNOWN]: 1 } })
    assert.equal(s.byOperator.find((g) => g.value === 'TransCayma S.A.C.').total, 1, 'the way counts for its operator')
    assert.equal(s.byNetwork.map((g) => g.value).filter(Boolean).length, 2, 'misspelt network values stay separate (that is a finding)')
    assert.deepEqual(s.dataQuality, { withoutPublicTransport: 0, unexpectedPublicTransport: 1, stopPositionWithoutMode: 1, busNo: 0, withoutName: 6 })
})

test('formatSummary: markdown tables with the class counts and the membership line', () => {
    const text = formatSummary(summarize(buildRows(fixture().elements)), { osmBase: '2026-10-28T21:40:20Z', source: 'fixture' })
    assert.match(text, /^# Paradas de bus en OSM — Arequipa \(2026-10-28T21:40:20Z\)/)
    assert.match(text, /· 11 nodos \+ 1 ways/)
    assert.match(text, /\| infraestructura \| 4 \| 33\.3 % \|/)
    assert.match(text, /\| señalizada \| 2 \| 16\.7 % \|/)
    assert.match(text, /\| sin señal ni infraestructura \| 1 \| 8\.3 % \|/)
    assert.match(text, /\| sin clasificar \| 5 \| 41\.7 % \|/)
    assert.match(text, /\| \*\*total\*\* \| \*\*12\*\* \| 100 % \|/)
    assert.match(text, /Miembros de alguna relación de ruta \(type=route\): \*\*3\*\* de 12\./)
    assert.match(text, /\| Integra Arequipa S\.A\.C\. \| 2 \| 1 \| 0 \| 0 \| 1 \|/)
    assert.match(text, /\| \(sin operator\) \| 8 \|/)
    assert.match(text, /1 stop_position sin modo/)
})

function fakeFetch(responses) {
    const calls = []
    const impl = async (url, init) => {
        calls.push({ url, init })
        const next = responses.shift()
        if (!next) throw new Error('fakeFetch: no response left')
        if (next instanceof Error) throw next
        return { ok: next.status >= 200 && next.status < 300, status: next.status, text: async () => next.body }
    }
    return { impl, calls }
}
const okBody = JSON.stringify({ osm3s: {}, elements: [] })
const noSleep = () => { const waits = []; return { waits, sleep: async (ms) => { waits.push(ms) } } }

test('fetchOverpass: posts the form-encoded query with identifying headers', async () => {
    const { impl, calls } = fakeFetch([{ status: 200, body: okBody }])
    const json = await fetchOverpass('out count;', { urls: ['https://a/api'], fetchImpl: impl, log: () => {} })
    assert.deepEqual(json.elements, [])
    assert.equal(calls.length, 1)
    assert.equal(calls[0].url, 'https://a/api')
    assert.equal(calls[0].init.method, 'POST')
    assert.equal(calls[0].init.body, 'data=out%20count%3B')
    assert.equal(calls[0].init.headers['Content-Type'], 'application/x-www-form-urlencoded')
    assert.match(calls[0].init.headers['User-Agent'], /trufi-arequipa/)
    assert.ok(calls[0].init.signal instanceof AbortSignal)
})

test('fetchOverpass: 502 on the first endpoint falls through to the mirror in the same round', async () => {
    const { impl, calls } = fakeFetch([
        { status: 502, body: '# 502 Gateway Timeout\n\nThis Overpass API server is currently at capacity.' },
        { status: 200, body: okBody },
    ])
    const { waits, sleep } = noSleep()
    const json = await fetchOverpass('q', { urls: ['https://a/api', 'https://b/api'], fetchImpl: impl, sleep, log: () => {} })
    assert.deepEqual(json.elements, [])
    assert.deepEqual(calls.map((c) => c.url), ['https://a/api', 'https://b/api'])
    assert.deepEqual(waits, [], 'no wait when the mirror answers')
})

test('fetchOverpass: exponential backoff across rounds, capped', async () => {
    const { impl, calls } = fakeFetch([
        { status: 502, body: 'at capacity' },
        new Error('fetch failed'),
        { status: 429, body: 'too many' },
        { status: 200, body: '<html>not json</html>' },
        { status: 200, body: JSON.stringify({ remark: 'runtime error: Query timed out in "query" at line 3 after 120 seconds.', elements: [] }) },
        { status: 504, body: 'gateway timeout' },
        { status: 200, body: okBody },
    ])
    const { waits, sleep } = noSleep()
    const logs = []
    await fetchOverpass('q', { urls: ['https://a/api', 'https://b/api'], attempts: 5, baseDelayMs: 10, maxDelayMs: 25, fetchImpl: impl, sleep, log: (m) => logs.push(m) })
    assert.equal(calls.length, 7)
    assert.deepEqual(waits, [10, 20, 25], 'doubles and caps at maxDelayMs')
    assert.ok(logs.some((m) => /non-JSON response/.test(m)))
    assert.ok(logs.some((m) => /runtime error/.test(m)))
})

test('fetchOverpass: a timeout is retried like any other failure', async () => {
    const timeout = new DOMException('The operation was aborted due to timeout', 'TimeoutError')
    const { impl } = fakeFetch([timeout, { status: 200, body: okBody }])
    const { waits, sleep } = noSleep()
    const logs = []
    await fetchOverpass('q', { urls: ['https://a/api'], baseDelayMs: 5, fetchImpl: impl, sleep, log: (m) => logs.push(m) })
    assert.deepEqual(waits, [5])
    assert.ok(logs.some((m) => /timeout after/.test(m)))
})

test('fetchOverpass: HTTP 400 is a query error and is not retried', async () => {
    const { impl, calls } = fakeFetch([{ status: 400, body: '<p><strong>Error</strong>: line 8: parse error: \';\' expected - \'out\' found. </p>' }, { status: 200, body: okBody }])
    const { waits, sleep } = noSleep()
    await assert.rejects(
        fetchOverpass('q', { urls: ['https://a/api', 'https://b/api'], fetchImpl: impl, sleep, log: () => {} }),
        (err) => err instanceof review.OverpassQueryError && /parse error/.test(err.message),
    )
    assert.equal(calls.length, 1)
    assert.deepEqual(waits, [])
})

test('fetchOverpass: gives up after the configured attempts with the last error', async () => {
    const { impl, calls } = fakeFetch([{ status: 503, body: 'a' }, { status: 502, body: 'b' }, { status: 502, body: 'c' }, { status: 503, body: 'd' }])
    const { waits, sleep } = noSleep()
    await assert.rejects(
        fetchOverpass('q', { urls: ['https://a/api', 'https://b/api'], attempts: 2, baseDelayMs: 1, fetchImpl: impl, sleep, log: () => {} }),
        /failed after 2 attempt\(s\) on 2 endpoint\(s\): HTTP 503 from https:\/\/b\/api: d/,
    )
    assert.equal(calls.length, 4)
    assert.deepEqual(waits, [1])
})

test('endpointsFromEnv: OVERPASS_URL replaces the default list', () => {
    assert.deepEqual(endpointsFromEnv({}), review.DEFAULT_OVERPASS_URLS)
    assert.deepEqual(endpointsFromEnv({ OVERPASS_URL: 'http://localhost:12345/api/interpreter' }), ['http://localhost:12345/api/interpreter'])
    assert.equal(review.DEFAULT_OVERPASS_URLS[0], 'https://overpass-api.de/api/interpreter')
    assert.ok(review.DEFAULT_OVERPASS_URLS.length >= 2, 'at least one mirror as fallback')
})

test('baseAgeDays: age of the osm_base timestamp, null when absent', () => {
    const now = Date.parse('2026-10-28T22:00:00Z')
    assert.equal(review.baseAgeDays('2026-10-28T21:40:20Z', now) < 0.02, true)
    assert.equal(Math.floor(review.baseAgeDays('2026-06-01T08:52:28Z', now)), 149)
    assert.equal(review.baseAgeDays(undefined, now), null)
    assert.equal(review.baseAgeDays('not a date', now), null)
    assert.equal(review.STALE_AFTER_DAYS, 2)
})

test('run: warns when the endpoint serves a stale OSM base, stays quiet when fresh', async () => {
    const outDir = fs.mkdtempSync(path.join(os.tmpdir(), 'stops-review-'))
    const warnings = []
    const opts = { write: () => {}, warn: (s) => warnings.push(s) }
    await run(['--from', FIXTURE, '--out', outDir], { ...opts, now: Date.parse('2026-10-29T12:00:00Z') })
    assert.deepEqual(warnings, [], 'fixture base is 2026-10-28: fresh the next day')
    await run(['--from', FIXTURE, '--out', outDir], { ...opts, now: Date.parse('2026-12-01T00:00:00Z') })
    assert.equal(warnings.length, 1)
    assert.match(warnings[0], /WARNING: the OSM data is 33 days old \(base 2026-10-28T21:40:20Z\)/)
    assert.match(warnings[0], /OVERPASS_URL=https:\/\/overpass-api\.de\/api\/interpreter/)
    const stale = path.join(outDir, 'no-base.json')
    fs.writeFileSync(stale, JSON.stringify({ elements: fixture().elements }))
    await run(['--from', stale, '--out', outDir], opts)
    assert.equal(warnings.length, 2)
    assert.match(warnings[1], /no osm3s\.timestamp_osm_base/)
    fs.rmSync(outDir, { recursive: true, force: true })
})

test('run --from: writes both files into --out and prints the summary', async () => {
    const outDir = fs.mkdtempSync(path.join(os.tmpdir(), 'stops-review-'))
    let printed = ''
    const result = await run(['--from', FIXTURE, '--out', outDir], { write: (s) => { printed += s } })
    assert.equal(result.rows.length, 12)
    assert.equal(fs.readFileSync(result.csvPath, 'utf8'), toCsv(result.rows))
    const fc = JSON.parse(fs.readFileSync(result.geojsonPath, 'utf8'))
    assert.equal(fc.features.length, 12)
    assert.equal(fc.osm_base, '2026-10-28T21:40:20Z')
    assert.deepEqual(fc.bbox, [bounds.west, bounds.south, bounds.east, bounds.north])
    assert.equal(fc.generated, undefined)
    assert.match(printed, /\| \*\*total\*\* \| \*\*12\*\* \| 100 % \|/)
    assert.match(printed, new RegExp(`Escrito ${result.csvPath.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}`))
    fs.rmSync(outDir, { recursive: true, force: true })
})

test('run: queries Overpass through the injected fetch and honours OVERPASS_URL', async () => {
    const outDir = fs.mkdtempSync(path.join(os.tmpdir(), 'stops-review-'))
    const { impl, calls } = fakeFetch([{ status: 200, body: JSON.stringify(fixture()) }])
    const rawPath = path.join(outDir, 'raw.json')
    const result = await run(['--out', outDir, '--raw', rawPath], { env: { OVERPASS_URL: 'https://local/api' }, write: () => {}, fetchImpl: impl })
    assert.equal(calls.length, 1)
    assert.equal(calls[0].url, 'https://local/api')
    assert.equal(decodeURIComponent(calls[0].init.body.slice('data='.length)), buildQuery(bounds))
    assert.equal(result.summary.total, 12)
    assert.equal(JSON.parse(fs.readFileSync(rawPath, 'utf8')).elements.length, fixture().elements.length)
    fs.rmSync(outDir, { recursive: true, force: true })
})
