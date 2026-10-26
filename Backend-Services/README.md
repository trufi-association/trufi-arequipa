# Arequipa Bus - Backend Services
## Introduction

The server structure is based on Docker and NGINX due to their security management and scalability. For this reason, each service should be considered a Docker module/container that is added to the NGINX service.

### Server Structure

<img src="./Diagram/structure.png" hspace="20"/>

## What this folder contains

| Path | What it is |
|------|------------|
| `docker-compose.yml` | Runs the three services below on one Docker network (`trufi-server`). |
| `otp/` | OpenTripPlanner **1.5.0** (Java 8). `Dockerfile` (base image `eclipse-temurin:8-jre`), `run.sh` (builds `Graph.obj` on the first start and serves it afterwards) and `data/` with the inputs: `gtfs.zip` (the builder's `GTFS-Peru-Arequipa/out/city.gtfs.zip`, copied as is), `arequipa.osm.pbf` (OSM extract clipped to the city with margin, lon −71.75..−71.30 / lat −16.65..−16.20), `build-config.json` (`maxTransferDistance: 500` — keeps the graph at ~60 MB instead of ~365 MB with the 10 000 synthetic stops; itineraries are identical), `otp-config.json`, `router-config.json`. |
| `updater/` | **Updater**, a .NET 8 web API (`OTP-Updater`) that stores the responses of the in-app survey in PostgreSQL (`/Survey/...`), has an admin login with JWT (`/Auth/...`) and exposes `/health`. Its EF Core migrations run automatically at start. |
| `Diagram/` | The pictures used in this README. |
| `.env.example` | Template for the secrets the compose file needs. See [Configuration and secrets](#configuration-and-secrets). |

### What this folder does not contain

The production server also runs, each one as its own Docker Compose project outside this repository:

- the NGINX reverse proxy with TLS, built with [Trufi Server](https://github.com/trufi-association/trufi-server) (see [Configuration - Nginx](#configuration---nginx));
- **Photon** for place search (`/photon`);
- the **static map tiles** (`/static-maps/...`);
- the WordPress site served at the root of the domain.

## Modules
- OpenTripPlanner: It is the main service of the server; it calculates the most suitable route for a query.
- Updater: It is responsible for handling queries for services with different purposes (today, the in-app survey).
- Postgres: It is the database that records the necessary data for the app.

### OpenTripPlanner

It can calculate optimized routes by integrating different means of transportation.
For its operation, it requires two files.

|File Type                                |Format|Function                        |
|-----------------------------------------|------|--------------------------------|
|GTFS (General Transit Feed Specification)|Zip   |Public transportation data      |
|PBF (Protocolbuffer Binary Format)       |Pbf   |Road and mobility infrastructure|

#### Creation of the GTFS and PBF files

##### GTFS
The updated data to create the GTFS file is available in OpenStreetMap. To download and organize the data in GTFS format, it is necessary to use the tool provided by Trufi. [Trufi GTFS Builder](https://github.com/trufi-association/trufi-gtfs-builder)

##### PBF
You must obtain the .pbf file for Peru or South America from Geofabrik or BBBike.

Example to download Peru from Geofabrik:

```bash
wget https://download.geofabrik.de/south-america/peru-latest.osm.pbf

```

To extract only Arequipa, you can use Osmium or Osmosis:

- [Download osmium-tool](https://osmcode.org/osmium-tool/)
- [Download osmosis](https://github.com/openstreetmap/osmosis/releases/latest)

Define the boundaries of Arequipa in a .poly file. You can generate it from [polygons.openstreetmap.fr](https://polygons.openstreetmap.fr/)
Then, execute the following command to clip:

```bash
# Osmium
osmium extract --polygon=arequipa.poly peru-latest.osm.pbf -o arequipa.osm.pbf
```

Use the approximate boundaries of Arequipa
```bash
# Osmosis
osmosis --read-pbf peru-latest.osm.pbf --bounding-box top=-16.28546234927424 left=-71.68530956865706 bottom=-16.577267400595446 right=-71.44366525499784 --write-pbf arequipa.osm.pbf
```

## Configuration and secrets

The compose file reads the database credentials from a `.env` file placed next to `docker-compose.yml`. The file is ignored by git: never commit it.

```bash
cp .env.example .env
# edit .env and set POSTGRES_PASSWORD and JWT_KEY
```

| Variable            | Required                                   | Default       | Used by                                                          |
|---------------------|--------------------------------------------|---------------|------------------------------------------------------------------|
| `POSTGRES_PASSWORD` | yes, `docker compose` refuses to start without it | -        | `postgres` (superuser password) and `updater` (connection string) |
| `POSTGRES_USER`     | no                                         | `root`        | same                                                             |
| `POSTGRES_DB`       | no                                         | `arequipa_db` | same                                                             |
| `JWT_KEY`           | yes                                        | -             | `updater` (signs the admin JWT tokens, `JwtSettings:Key`)        |

The updater receives its connection string through the `ConnectionStrings__DefaultConnection` environment variable set in `docker-compose.yml`; it overrides the value in `updater/OTP-Updater/appsettings.json`, which deliberately carries no password. The same goes for `JwtSettings__Key` (the key that signs the updater's admin tokens): `appsettings*.json` leave it empty and the compose file sets it from `JWT_KEY`. To run the updater outside Docker, set that variable yourself (or use `dotnet user-secrets`).

The `postgres` image only applies `POSTGRES_*` when it initialises an **empty** `postgres_data/` directory. Changing the password in `.env` does not change the password of an existing database: change it in the database first (`ALTER USER`), then update `.env` and recreate the `updater` container.

## Configuration - Nginx

For server configuration, we can use the application [Trufi Server](https://github.com/trufi-association/trufi-server) provided by Trufi to manage the different services, adding the necessary extensions to the NGINX configuration file.

```conf
location /otp/ {
    proxy_pass http://otp:8080/otp/;
}
location /Survey/ {
    proxy_pass http://updater:5000/Survey/;
}
```

## Installation

To start the server installation, the only requirement is that Docker is installed and available.

### Preparation

1. Create the `.env` file as described in [Configuration and secrets](#configuration-and-secrets).
2. The files (GTFS and PBF) must be located in the directory `otp/data`.

<img src="./Diagram/gtfs-pbf-folder.png" hspace="20"/>

Once the requirements have been reviewed, the following command should be executed to proceed with the installation.

```bash
docker compose build
```

Then, the following command should be executed to start the server execution.

```bash
docker compose up
```

For the proper functioning of each module, we will describe more details in the following sections.

### Update GTFS and PBF

Replace the files (GTFS and PBF) in the directory `otp/data` with their new versions (either one or both) and execute the command.

```bash
docker compose build otp --no-cache
```
