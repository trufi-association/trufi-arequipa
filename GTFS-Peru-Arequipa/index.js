const { osmToGtfs, OSMOverpassDownloader, OSMPBFReader } = require('trufi-gtfs-builder')

// Source of the OSM data. Overpass (live) by default; set OSM_PBF=<path to an .osm.pbf
// extract covering the city> to run offline or when www.overpass-api.de is at capacity.
const osmDataGetter = process.env.OSM_PBF
    ? new OSMPBFReader(process.env.OSM_PBF)
    : new OSMOverpassDownloader({
        south: -16.489732,
        west: -71.622936,
        north: -16.303314,
        east: -71.453334,
    })

osmToGtfs({
    outputFiles: { outputDir: __dirname + '/out', trufiTPData: true, gtfs: true, gtfsZip: true, routes: true },
    geojsonOptions: {
        osmDataGetter,
        skipRoute: (route) => {
            // Skip relations tagged as disused bus routes
            if (route.tags['disused:route'] === 'bus') {
                return false
            }
            if (route.tags['route'] === 'bus') {
                return true
            }
            return false
        }
    },
    gtfsOptions: {
        stopsConfig: () => ({ mode: "fakeStops" }),
        // Fallback only: every relation carries duration=* in OSM (2.16 honors it).
        // 50 is the library's uncalibrated placeholder; measured implied speed in Arequipa is ~13 km/h.
        vehicleSpeed: () => 20,
        // Trust OSM duration=* unless it implies a walking-pace bus (< 7 km/h): that is a
        // tagging mistake (e.g. duration=120 on a 9 km line), not a running time. Those
        // relations fall back to vehicleSpeed and are reported so the tag gets fixed in OSM.
        // 7 and not 6: at 6 the two directions of A: Alto Libertad, Gráficos: Umacollo and
        // Atalaya split (one at 20 km/h, the other kept at 6.0-7.1 km/h); the next slowest
        // plausible line runs at 7.6 km/h.
        tripDuration: (route, osmSeconds, lengthMeters) => {
            if (osmSeconds === undefined || !(lengthMeters > 0)) return osmSeconds
            const kmh = (lengthMeters / 1000) / (osmSeconds / 3600)
            if (kmh < 7) {
                console.warn(`duration=* on relation ${route.properties.id} (${route.properties.name}) implies ${kmh.toFixed(1)} km/h; ignoring it`)
                return undefined
            }
            return osmSeconds
        },
        stopNameBuilder: (stops) => {
            if (!stops || stops.length == 0) {
                stops = ["Innominada"]
            }
            return stops.join(" y ")
        },
        routePerRelation: true,
        // attributions.txt (ODbL chain): the OpenStreetMap contributors row is written by the
        // builder; these are the organisations behind this feed. LICENSE (ODbL 1.0) is the default.
        attributions: [
            { attribution_id: "trufi", organization_name: "Trufi Association", is_producer: 1, attribution_url: "https://www.trufi-association.org/" },
            { attribution_id: "muni-arequipa", organization_name: "Municipalidad Provincial de Arequipa", is_authority: 1, attribution_url: "https://www.muniarequipa.gob.pe/" },
        ],
        agencyTimezone: "America/Lima",
        agencyUrl: "https://arequipabus.muniarequipa.gob.pe/",
        defaultFares: { currencyType: "PEN" },
        feed: {
            publisherUrl: "https://github.com/trufi-association/trufi-arequipa/tree/main/GTFS-Peru-Arequipa",
            publisherName: "Trufi Association",
            lang: "es",
            version: new Date().toUTCString(),
            contactEmail: "feedback@trufi.app",
            contactUrl: "https://arequipabus.muniarequipa.gob.pe/form",
            startDate: "20000101",
            endDate: "21000101",
            id: "arequipa-pe"
        }
    }
}).catch(error => {
    console.error(error)
    process.exitCode = 1   // a failed run (e.g. Overpass at capacity) must not look like a success
})
