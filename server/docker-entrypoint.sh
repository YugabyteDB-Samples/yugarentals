#!/bin/bash
# printenv
if [[ $DB_DEPLOYMENT_TYPE == "docker" && $DB_TYPE == "yugabyte" ]]; 
then
    until psql -h host.docker.internal -p 5433 -U yugabyte -c 'show server_version' ; do sleep 1 ; done 2>/dev/null
    until schemaInitialized=$(psql -h host.docker.internal -p 5433 -U yugabyte -t -c  "select count(schema_name) FROM information_schema.schemata WHERE schema_name = 'admin'"); echo 'checking for schema' ; do sleep 1 ; done 2>/dev/null
    echo $schemaInitialized
    if [[ $schemaInitialized == "0" ]];
    then
        echo "this is where sql initialization goes down"
    fi
fi

npm start