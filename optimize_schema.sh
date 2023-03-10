#!/bin/bash

if [ $# -eq 0 ];
then
  echo "$0: Missing arguments"
  exit 1
elif [ $# -gt 2 ];
then
  echo "$0: Too many arguments: $@"
  exit 1
else
    for ARGUMENT in "$@"
    do
        KEY=$(echo $ARGUMENT | cut -f1 -d=)

        KEY_LENGTH=${#KEY}
        VALUE="${ARGUMENT:$KEY_LENGTH+1}"

        export "$KEY"="$VALUE"
    done

    echo "Export dir: $export_dir"
    echo "Updating Table DDL"
    cp -i ./sql_scripts/voyager/table_updated.sql $export_dir/schema/tables/table.sql
    echo "Updating Trigger DDL"
    cp -i ./sql_scripts/voyager/trigger_updated.sql $export_dir/schema/triggers/trigger.sql
fi