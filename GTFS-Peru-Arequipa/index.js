const { osmToGtfs, OSMOverpassDownloader } = require('trufi-gtfs-builder')

// The default routeBuilder cuts the OSM relation `name` at the FIRST ":" to
// build `route_long_name`. Arequipa route codes contain colons themselves,
// so e.g. `C-9 Bus "3 de octubre: B": La Campiña II → Parque Selva Alegre`
// was truncated to `C-9 Bus "3 de octubre`. We override the builder to use
// `from`, `to` and `ref` properties to build the long name. The library 
// exposes this through the supported `gtfsBuilders` config option, so 
// no fork/patch is needed.
const gtfsBuildersModule = require('trufi-gtfs-builder/dist/geojson_to_gtfs/gtfsBuilders')
const { routeBuilder: defaultRouteBuilder } = gtfsBuildersModule.default || gtfsBuildersModule

function splitRouteName(properties) {
    const from = (properties.from || '').trim()
    const to = (properties.to || '').trim()
    const ref = (properties.ref || '').trim()

    return `Bus ${ref}: ${from} → ${to}`
}

function routeBuilder(features, options) {
    const routes = defaultRouteBuilder(features, options)

    const longNameByKey = new Map()
    for (const feature of features) {
        const properties = feature[0].properties
        const key = properties.id
        if (!longNameByKey.has(key)) longNameByKey.set(key, splitRouteName(properties))
    }

    for (const route of routes) {
        const key = route.route_id
        if (longNameByKey.has(key)) route.route_long_name = longNameByKey.get(key)
    }

    return routes
}

osmToGtfs({
    gtfsBuilders: { routeBuilder },
    outputFiles: { outputDir: __dirname + '/out', trufiTPData: true, gtfs: true,routes: true,},
    geojsonOptions: {
        osmDataGetter: new OSMOverpassDownloader({
            south: -16.489733,
            west: -71.622937,
            north: -16.303315,
            east: -71.453335,
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
        vehicleSpeed: () => 50,
        stopNameBuilder: (stops) => {
            if (!stops || stops.length == 0) {
                stops = ["Innominada"]
            }
            return stops.join(" y ")
        },
        routePerRelation: true,
        agencyTimezone: "America/Lima",
        agencyUrl: "https://arequipabus.app/",
        defaultFares: { currencyType: "PEN" },
        feed: {
            publisherUrl: "https://arequipabus.app",
            publisherName: "Arequipa Bus",
            lang: "es",
            version: new Date().toUTCString(),
            contactEmail: "email@arequipabus.app",
            contactUrl: "http://support.arequipabus.app",
            startDate: "20000101",
            endDate: "21000101",
            id: "arequipa-pe"
        }
    }
}).catch(error => console.error(error))
