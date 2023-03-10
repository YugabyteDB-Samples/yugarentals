# Local Manual Deployment

Follow this instruction if you wish to run the application components locally without Docker.

Users have the option to connect these services to YugabyteDB or Oracle Database.

These database deployments can be hosted in the cloud, with [YugabyteDB Managed](https://www.yugabyte.com/managed/) for YugabyteDB or any other cloud provider for Oracle Database. Alternatively, [YugabyteDB](https://docs.yugabyte.com/preview/quick-start/) or Oracle Database can be installed locally.

<!-- vscode-markdown-toc -->

- [Local Application Deployment](#local-application-deployment)
  - [Prerequisites](#prerequisites)
  - [Architecture](#architecture)
  - [Configure Your Environment](#configure-your-environment)
    - [Configuration for YugabyteDB](#configuration-for-yugabytedb)
    - [Configuration for Oracle Database](#configuration-for-oracle-database)
  - [Seed Your Database](#seed-your-database)
    - [Seed YugabyteDB](#seed-yugabytedb)
    - [Seed Oracle Database](#seed-oracle-database)
  - [Run Application Services](#run-application-services)
  - [Viewing The UI](#viewing-the-ui)

<!-- vscode-markdown-toc-config
    numbering=false
    autoSave=true
    /vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

## Prerequisites

1. Ensure your system is equipped to run JavaScript applications with Node.js v16.

2. if you're running on Oracle, be sure to download and configure the [Oracle Instant Client](https://www.oracle.com/database/technologies/instant-client.html) for your platform.

Oracle Database is not supported on machines running Apple ARM. To install the Oracle Client Libraries on Apple ARM:

1. Install [Rosetta](https://support.apple.com/en-us/HT211861).
2. Use Rosetta to install dependencies, following [these steps](https://developers.ascendcorp.com/how-to-install-oracle-instant-client-on-apple-silicon-m1-24b67f2dc743).
3. Verify the developer, following [these steps](http://oraontap.blogspot.com/2020/01/mac-os-x-catalina-and-oracle-instant.html).
4. Install Node.js v16 inside terminal running Rosetta.

## Architecture

- Frontend - ReactJS
- Backend Services - Node.js
- Database - YugabyteDB or Oracle Database

## Configure Your Environment

### Configuration for YugabyteDB

1. Clone the repository

```
git clone https://github.com/YugabyteDB-Samples/yugarentals.git
cd yugarentals/
```

2. Install the server dependencies

```
> cd server/ && npm install
```

3. Edit your database connection details.

YugaRentals uses the [Dotenv](https://www.npmjs.com/package/dotenv) package to configure it's application environment.

Update the environment variables in `/server/.env` to match your deployment.

```
# YugabyteDB Environment

DB_TYPE=yugabytedb
DB_USER=admin
DB_HOST=my-yugabytedb-managed-host
DB_PASSWORD=password
DB_NAME=yugabyte
DB_SSL_MODE=true
```

If running on YugabyteDB Managed, provide the downloaded root certificate in the `/server` directory as `root.crt`.

4. Install the client dependencies

```
> cd client/ && npm install
```

5. Build the UI

```
> npm run build
```

### Configuration for Oracle Database

1. Clone the repository

```
git clone https://github.com/YugabyteDB-Samples/yugarentals.git
cd yugarentals/
```

2. Install the server dependencies

```
> cd server/ && npm install
```

3. Edit your database connection details.

YugaRentals uses the [Dotenv](https://www.npmjs.com/package/dotenv) package to configure it's application environment.

Update the environment variables in `/server/.env` to match your deployment.

```
# Oracle environment

DB_TYPE=oracle
DB_USER=admin
DB_HOST=mymachine.example.com
DB_PASSWORD=admin123
DB_NAME=ORCL
DB_CLIENT_PATH=/path/to/oracleinstantclient
```

4. Install the client dependencies

```
> cd client/ && npm install
// Install node-oracledb package
> npm install oracledb
```

5. Build the UI

```
> npm run build
```

## Seed Your Databse

### Seed YugabyteDB

1. Find the schema and data files in the `sql_scripts/yugabyte` directory.
2. Install the appropriate command-line utility for your database. For YugabyteDB, install [ysqlsh](https://docs.yugabyte.com/preview/admin/ysqlsh).
3. Execute the files.

```
# Yugabyte
> ysqlsh -h 127.0.0.1 -p 5433 -U yugabyte -f sql_scripts/schema.sql
> ysqlsh -h 127.0.0.1 -p 5433 -U yugabyte -f sql_scripts/data.sql
```

### Seed Oracle Database

1. Find the schema and data files in the `sql_scripts/oracle` directory.
2. Install the appropriate command-line utility for your database. For Oracle Database, install [Oracle Instant Client](https://www.oracle.com/database/technologies/instant-client) and the associated SQL\*Plus utility.
3. Execute the files.

```
# SQL
> SQL > @/full/path/to/sql_scripts/oracle/schema.sql
> SQL > @/full/path/to/sql_scripts/oracle/data.sql
```

## Run Application Services

This application runs locally via a Node.js server.

Start the application

```
> cd server/ && node index.js
```

To enable auto-reload on file changes in developement using [Nodemon](https://www.npmjs.com/package/nodemon), you may alternatively start the application using

```
> cd server/ && npm start
```

## Viewing the UI

The application UI can be found at [localhost:8000](http://localhost:8000).

1. View the recent rentals and sales by category. <img width="1141" alt="Screen Shot 2023-03-09 at 6 42 07 PM" src="https://user-images.githubusercontent.com/2041330/224209662-31d385eb-5f8d-442d-ba34-23f453c7b37e.png">

2. If you'd like to simulate movie rentals, click the simulate button and observe the new rentals and updated aggregate data.
