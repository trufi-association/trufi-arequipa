const { osmToGtfs, OSMOverpassDownloader } = require('trufi-gtfs-builder')

osmToGtfs({
    outputFiles: { outputDir: __dirname + '/out', trufiTPData: true, gtfs: true, gtfsZip: true, routes: true },
    geojsonOptions: {
        osmDataGetter: new OSMOverpassDownloader({
            south: -16.489732,
            west: -71.622936,
            north: -16.303314,
            east: -71.453334,
        }), skipRoute: (route) => {
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
        // Trust OSM duration=* unless it implies a walking-pace bus (< 6 km/h): that is a
        // tagging mistake (e.g. duration=120 on a 9 km line), not a running time. Those
        // relations fall back to vehicleSpeed and are reported so the tag gets fixed in OSM.
        tripDuration: (route, osmSeconds, lengthMeters) => {
            if (osmSeconds === undefined) return undefined
            const kmh = (lengthMeters / 1000) / (osmSeconds / 3600)
            if (kmh < 6) {
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
