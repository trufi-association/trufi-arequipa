## INTRODUCTION 

Trufi’s General Transit Feed Specification (GTFS) tool allows you to create a map for Arequipa city. You can also send your route data to Google Maps, Open Trip Planner, OpenStreetMap, and other public atlases to keep navigation databases updated. 

Follow the steps below to create a public transportation map using our tool.

### Steps 

+ Step 1:  Download [trufi-arequipa](https://github.com/trufi-association/trufi-arequipa)

+ Step 2: Download three tools: [Nodsjs](https://nodejs.org/en), [Git]( https://github.com/git-guides/install-git), and a text code editor. We recommend [Visual Studio (VS) Code]( https://code.visualstudio.com/).

+ Step 3: Click on “code” and copy the HTTPS URL. 
You may choose to download GitHub Desktop and select the “GitHub CLI”. 
There is a login required to use this method. There is no login required to use the HTTPS method.
 
+ Step 4: Type Git clone and the HTTPS URL into the Git PowerShell command line.
 
+ Step 5: Find the Trufi GFTS folder on your device. Right-click it and copy the folder.

+ Step 6: Find the VS Code folder. Paste the Trufi folder inside it.
 
+ Step 7: Type npm install in the console to install all node dependencies.

+ Step 8: Under the output files set GFTS to true.

+ Step 9: Run the application in the VS Code terminal. Type: Node - .\examples\ your folder \index\js. 

In your output folder, there is a new README file. You can copy and paste its contents into a markdown viewer to see your new map and errors. 


## Optional Steps 

### Test a sample map

There are route examples inside the folder that allow you to visualize how the application works. 

- [ ] Work inside an index, run, and type node -.\examples\the example you want to work inside\index.js
 
- [ ] Test one of the sample maps, open its README file. Copy the markdown text. 
Navigate to a markdown reader and paste the text. Examine the output. 
Here, you can see the output layout and learn how to fix errors.

### Customize your application
 
To specify routes, operation times, and other local options, you can change the following elements:

- [ ] Add or update the "agencytimezone" element. Use it to add your transportation agency’s name. You may also use the default calendar option to set transportation operation times.

- [ ] Every city does not have stops included in its routes. The “fakestops” option allows you to create fake stops so that your output is not empty. If you live in a place without designated bus stops, select false under "fakestops" to create fake ones. The default interval is 100 meters. However, if you would like more or fewer stops, change the interval. 
 
- [ ] To build or add streets, type and inside the “return.stops.join" element.

- [ ] You have a section in your code called “stops”. If a stop name is unknown, type unknown in this section so that the map does not output an incorrect street name. 

### Running without Overpass

`node index.js` downloads the OSM data from `www.overpass-api.de`, which answers 502 "at capacity" when loaded. To run offline (or in CI) point `OSM_PBF` at an `.osm.pbf` extract that covers the city with margin (for example a Geofabrik Peru extract clipped with `osmium extract -b -71.75,-16.65,-71.30,-16.20`):

```bash
OSM_PBF=/path/to/arequipa.osm.pbf node index.js
```

The output is the same as from Overpass as long as the extract is as recent as the relations you expect.

## Stops review (issue #40)

The feed's stops are synthetic (`stopsConfig: fakeStops`: one every ~100 m along each route) because riders board anywhere. The municipality is inventorying the real stops, and [issue #40](https://github.com/trufi-association/trufi-arequipa/issues/40) asks for them classified as *con infraestructura* (shelter or bench) vs *señalizadas* (a sign only). `tools/stops-review.js` produces that inventory from OpenStreetMap:

```bash
npm ci
npm run stops-review          # or: node tools/stops-review.js
```

It queries Overpass for every bus-stop node inside the feed's bounding box (`bbox.js`, the same one `index.js` uses): `highway=bus_stop`, `public_transport=platform` + `bus=yes` and `public_transport=stop_position` + `bus=yes`, plus the `type=route` relations that list any of them as a member. It writes:

- `out/stops-review.csv`: one row per stop with `osm_id`, `lat`, `lon`, `class`, `name`, the inventory tags (`shelter`, `bench`, `sign`, `traffic_sign`, `covered`, `lit`, `bin`), `operator`, `network`, how many route relations include the stop (`route_relations`, `routes`) and the `osm_url` to open it in the editor. UTF-8; opens in Excel or LibreOffice.
- `out/stops-review.geojson`: the same rows as points, to drop on [geojson.io](https://geojson.io), uMap or QGIS.
- A Markdown summary on stdout: totals per class, per `operator` and per `network` (raw values, so misspellings show up), and how many stops are members of a route relation.

Options: `--from <overpass.json>` reuses a saved Overpass response (offline, reproducible), `--raw <file>` saves the response, `--out <dir>` changes the output folder, and `OVERPASS_URL=https://host/api/interpreter` uses that endpoint only (for example a local instance). Without it the tool tries `overpass-api.de` and then the public mirror `overpass.private.coffee` (formerly `overpass.kumi.systems`), retrying with exponential backoff (15 s doubling up to 120 s, 5 rounds) on 429/5xx, timeouts and non-JSON answers, which is what `overpass-api.de` asks for when it answers 502 "at capacity". HTTP 400 means the query itself is wrong and stops the run at once. A failed run exits with status 1. Public mirrors can lag the live OSM database by months (`overpass.private.coffee` served a 2026-06-01 base on 2026-10-28), so the summary header and the GeoJSON carry the `osm_base` timestamp of the data, and the tool warns on stderr when it is more than two days old: rerun later, or pin `OVERPASS_URL=https://overpass-api.de/api/interpreter`, if you need current data.

### Classification rules

| class | when the node carries | meaning |
|---|---|---|
| `infraestructura` | `shelter=yes`/`separate`, `bench=yes`/`separate`, `amenity=shelter`, `shelter_type=public_transport` or `covered=yes` | something to sit on or under |
| `señalizada` | `sign=yes` or `traffic_sign=*`, and nothing from the row above | a sign on a pole, no furniture |
| `sin señal ni infraestructura` | `sign=no` together with `shelter=no` or `bench=no` | the mapper checked and found nothing built |
| `sin clasificar` | none of the above (typically a bare `highway=bus_stop`) | not surveyed yet |

Infrastructure wins over the sign: a shelter with a sign is counted once, as `infraestructura`. `sign=*` is not a documented OSM key, but it is what the Arequipa inventory uses on the ground (261 of the 383 nodes on 2026-10-28), so the tool honours it next to the standard `traffic_sign=*`. A bare `highway=bus_stop` is *not* assumed to be signed: in Arequipa many of those nodes are customary boarding places without a pole.

### The same query in Overpass Turbo (no installation)

Paste this into [overpass-turbo.eu](https://overpass-turbo.eu) and press *Run* ([pre-filled link](https://overpass-turbo.eu/?Q=%5Bout%3Ajson%5D%5Btimeout%3A60%5D%3B%0A(%0A%20%20node%5B%22highway%22%3D%22bus_stop%22%5D(-16.489732%2C-71.622936%2C-16.303314%2C-71.453334)%3B%0A%20%20node%5B%22public_transport%22%3D%22platform%22%5D%5B%22bus%22%3D%22yes%22%5D(-16.489732%2C-71.622936%2C-16.303314%2C-71.453334)%3B%0A%20%20node%5B%22public_transport%22%3D%22stop_position%22%5D%5B%22bus%22%3D%22yes%22%5D(-16.489732%2C-71.622936%2C-16.303314%2C-71.453334)%3B%0A)%3B%0Aout%20body%3B&C=-16.3965;-71.5381;12&R)): it draws every bus stop in the bounding box, and *Export → GeoJSON / KML / GPX* downloads them.

```
[out:json][timeout:60];
(
  node["highway"="bus_stop"](-16.489732,-71.622936,-16.303314,-71.453334);
  node["public_transport"="platform"]["bus"="yes"](-16.489732,-71.622936,-16.303314,-71.453334);
  node["public_transport"="stop_position"]["bus"="yes"](-16.489732,-71.622936,-16.303314,-71.453334);
);
out body;
```

Filtered variants: [only the stops with infrastructure](https://overpass-turbo.eu/?Q=%5Bout%3Ajson%5D%5Btimeout%3A60%5D%3B%0A(%0A%20%20node%5B%22highway%22%3D%22bus_stop%22%5D%5B%22shelter%22%3D%22yes%22%5D(-16.489732%2C-71.622936%2C-16.303314%2C-71.453334)%3B%0A%20%20node%5B%22highway%22%3D%22bus_stop%22%5D%5B%22bench%22%3D%22yes%22%5D(-16.489732%2C-71.622936%2C-16.303314%2C-71.453334)%3B%0A%20%20node%5B%22highway%22%3D%22bus_stop%22%5D%5B%22covered%22%3D%22yes%22%5D(-16.489732%2C-71.622936%2C-16.303314%2C-71.453334)%3B%0A)%3B%0Aout%20body%3B&C=-16.3965;-71.5381;12&R) (`shelter=yes`, `bench=yes` or `covered=yes`) and [only the signed ones without infrastructure](https://overpass-turbo.eu/?Q=%5Bout%3Ajson%5D%5Btimeout%3A60%5D%3B%0Anode%5B%22highway%22%3D%22bus_stop%22%5D%5B%22sign%22%3D%22yes%22%5D%5B%22shelter%22!%3D%22yes%22%5D%5B%22bench%22!%3D%22yes%22%5D(-16.489732%2C-71.622936%2C-16.303314%2C-71.453334)%3B%0Aout%20body%3B&C=-16.3965;-71.5381;12&R) (`sign=yes` and neither `shelter=yes` nor `bench=yes`, a close approximation of the rules above).

### Tests

`npm test` runs the unit tests (`node --test`, no extra dependencies) for the classifier, the CSV and GeoJSON writers and the Overpass client, against `tools/fixtures/overpass-sample.json`, a handful of real nodes from the Arequipa inventory. The `Test GTFS tools` workflow runs them on every pull request that touches this folder.
