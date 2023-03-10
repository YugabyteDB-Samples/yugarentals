# Local Docker Deployment

Follow this instruction if you wish to run the entire application with all the components on your local machine using Docker and Docker-Compose.

<!-- vscode-markdown-toc -->

- [Local Docker Deployment](#local-application-deployment)
  - [Prerequisites](#prerequisites)
  - [Architecture](#architecture)
  - [Run Application Services](#run-application-services)
    - [Running on YugabyteDB within Docker](#running-on-yugabytedb-within-docker)
    - [Running on YugabyteDB Managed or Custom YugabyteDB Deployment](#running-on-yugabytedb-managed-or-custom-yugabytedb-deployment)
  - [Seed Database](#seed-database)
  - [Viewing The UI](#viewing-the-ui)

<!-- vscode-markdown-toc-config
    numbering=false
    autoSave=true
    /vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

## Prerequisites

- Install [Docker and Docker Desktop](https://docs.docker.com/get-docker/)

## Architecture

- Frontend - ReactJS
- Backend Services - Node.js
- Database - YugabyteDB
- Infrastructure - Docker / Docker-Compose

## Run Application Services

This deployment option runs application services locally via [Docker-Compose](https://docs.docker.com/compose/).

YugabyteDB deployments can be hosted in the cloud, with [YugabyteDB Managed](https://www.yugabyte.com/managed/) for YugabyteDB. Alternatively, YugabyteDB can be hosted within Docker.

#### **Running on YugabyteDB within Docker**

This is a self-contained deployment, which doesn't require any additional configuration.

1. Clone the repository

```
git clone https://github.com/YugabyteDB-Samples/yugarentals.git
cd yugarentals/
```

2. Start the application:

```
docker compose -f docker-compose-local.yaml up
```

3. View the YugabyteDB UI Console at [localhost:7001](http://localhost:7001).

<img width="1584" alt="Screen Shot 2022-11-02 at 7 36 17 PM" src="https://user-images.githubusercontent.com/2041330/199637751-616d19ff-e474-4d17-956c-fe672c53052c.png">

#### **Running on YugabyteDB Managed or Custom YugabyteDB Deployment**

1. Clone the repository

```
git clone https://github.com/YugabyteDB-Samples/yugarentals.git
cd yugarentals/
```

2. Open the `docker-compose.yaml` file and provide the connection details via the `DB_` settings.

3. Start the application:

```
docker compose -f docker-compose.yaml up
```

## Seed Database

Fully Dockerized deployments will seed the database automatically.

For custom database deployments:

1. Find the schema and data files `/sql_scripts/yugabyte/schema.sql` and `/sql_scripts/yugabyte/data`.
2. Install the appropriate command-line utility for your database. For YugabyteDB, install [ysqlsh](https://docs.yugabyte.com/preview/admin/ysqlsh).
3. Execute the files.

```
# Yugabyte
> ysqlsh -h 127.0.0.1 -p 5433 -U yugabyte -f ./sql_scripts/yugabyte/schema.sql
> ysqlsh -h 127.0.0.1 -p 5433 -U yugabyte -f ./sql_scripts/yugabyte/data.sql
```

## Viewing the UI

The application UI can be found at [localhost:3000](http://localhost:3000).

1. View the recent rentals and sales by category.

<img width="1141" alt="Screen Shot 2023-03-09 at 6 42 07 PM" src="https://user-images.githubusercontent.com/2041330/224209662-31d385eb-5f8d-442d-ba34-23f453c7b37e.png">

2. If you'd like to simulate movie rentals, click the simulate button and observe the new rentals and updated aggregate data.
