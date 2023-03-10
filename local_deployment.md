# Local Manual Deployment

Follow this instruction if you wish to run the application components locally without Docker.

<!-- vscode-markdown-toc -->

- [Local Application Deployment](#local-application-deployment)
  - [Prerequisites](#prerequisites)
  - [Architecture](#architecture)
  - [Configure Your Environment](#configure-your-environment)
  - [Run Application Services](#run-application-services)
  - [Seed Database](#seed-database)
  - [Viewing The UI](#viewing-the-ui)

<!-- vscode-markdown-toc-config
    numbering=false
    autoSave=true
    /vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

## Prerequisites

- Ensure your system is equipped to run JavaScript applications with Node.js v16.

* if you're running on Oracle, be sure to download and configure the [Oracle Instant Client](https://www.oracle.com/database/technologies/instant-client) for your platform.

## Architecture

- Frontend - ReactJS
- Backend Services - Node.js
- Database - YugabyteDB or Oracle Database

## Configure Your Environment

YugaRentals uses the [Dotenv](https://www.npmjs.com/package/dotenv) package to configure its application environment.

1. Install the server dependencies

```
> cd server/ && npm install
```

2. Edit your database connection details in `/api/.env`.
3. Install the client dependencies

```
> cd client/ && npm install
```

4. Build the UI

```
> npm run build
```

## Run Application Services

This application runs locally via a Node.js server.

Users have the option to connect these services to YugabyteDB or Oracle Database.

These database deployments can be hosted in the cloud, with [YugabyteDB Managed](https://www.yugabyte.com/managed/) for YugabyteDB or any other cloud provider for Oracle Database. Alternatively, [YugabyteDB](https://docs.yugabyte.com/preview/quick-start/) or Oracle Database can be installed locally.

If running on YugabyteDB Managed, provide the downloaded root certificate in the `/server` directory as `root.crt`.

Start the application

```
> cd api/ && node index.js
```

To enable auto-reload on file changes in developement using [Nodemon](https://www.npmjs.com/package/nodemon), you may alternatively start the application using

```
> cd api/ && npm start
```

## Seed Database

1. Find the schema and data files in `/api/schema` and `/api/data`.
2. Install the appropriate command-line utility for your database. For YugabyteDB, install [ysqlsh](https://docs.yugabyte.com/preview/admin/ysqlsh) and for Oracle Database, install [Oracle Instant Client](https://www.oracle.com/database/technologies/instant-client) and the associated SQL\*Plus utility.
3. Execute the files.

```
# Yugabyte
> ysqlsh -h 127.0.0.1 -p 5433 -U yugabyte -f sql_scripts/schema.sql
> ysqlsh -h 127.0.0.1 -p 5433 -U yugabyte -f sql_scripts/data.sql

# SQL
> SQL > @/full/path/to/sql_scripts/oracle/schema.sql
> SQL > @/full/path/to/sql_scripts/oracle/data.sql
```

## Viewing the UI

The application UI can be found at [localhost:8000](http://localhost:8000).

1. View the recent rentals and sales by category. <img width="1141" alt="Screen Shot 2023-03-09 at 6 42 07 PM" src="https://user-images.githubusercontent.com/2041330/224209662-31d385eb-5f8d-442d-ba34-23f453c7b37e.png">

2. If you'd like to simulate movie rentals, click the simulate button and observe the new rentals and updated aggregate data.
