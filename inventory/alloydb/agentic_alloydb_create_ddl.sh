#!/bin/bash
# this scrit will create the DDL mentioned in sql file
. /home/deepak_kumar214e17/agentic_config.param

# Export password for psql
export PGPASSWORD=$PASSWORD

# SQL to create table
sudo apt install postgresql-client -y
psql --version

psql -h $HOST -p $PORT -U $USER -d $DATABASE_NAME -f $SQL_FILE