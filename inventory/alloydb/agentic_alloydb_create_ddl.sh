#!/bin/bash
. /home/deepak_kumar214e17/agentic_config.param
# --- Configuration ---
#PROJECT_ID="cog01k76j1fr1385r4k0300aq7hxg"
#REGION="us-central1"
#CLUSTER_ID="aia-alloydb"
#INSTANCE_ID="aia-alloydb-primary"
#HOST="10.0.0.11"
#PORT="5432"
#DATABASE_NAME="postgres"
#SQL_FILE="agentic_alloydb_create_table.sql"
#BUCKET="gs://alloydb-usecase/uploads"
#USER="postgres"
#PASSWORD="AlloyDB_Dev"

# Export password for psql
export PGPASSWORD=$PASSWORD

# SQL to create table
sudo apt install postgresql-client -y
psql --version

psql -h $HOST -p $PORT -U $USER -d $DATABASE_NAME -f $SQL_FILE