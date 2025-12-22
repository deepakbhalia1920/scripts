#!/bin/bash
# Purpose: Create database objects (DDL) in a Cloud SQL for PostgreSQL instance
#          by executing a local SQL file via the Cloud SQL Auth Proxy.
# Usage:   ./agentic_cloudsql_create_ddl.sh
# Requires:
#   - cloud-sql-proxy available in PATH
#   - psql (PostgreSQL client) installed
#   - gcloud authenticated to the correct project
. /home/deepak_kumar214e17/cloudsql_gc/agentic/script/agentic_config.param

# --- Configuration ---
#PROJECT_ID="cog01k76j1fr1385r4k0300aq7hxg"  # GCP project ID
#REGION="us-central1" # Cloud SQL instance region
#CLUSTER_ID="aia-alloydb"
#INSTANCE_NAME="cloudsql-postgres-instance-0112" # Cloud SQL instance name
#HOST="127.0.0.1" # Local host used by the proxy
#PORT="5432" # Local port used by the proxy
#DB_NAME="postgres" # Target database for running DDL
#SQL_FILE="agentic_cloudsql_create_table.sql" # SQL script containing DDL
#BUCKET="gs://alloydb-usecase/uploads"
#DB_USER="postgres" # Database user
#PASSWORD="Cloudsql@dev1" #Database password

# Export password for psql
export PGPASSWORD=$PASSWORD

# Start Cloud SQL Auth Proxy
cloud-sql-proxy "$PROJECT_ID:$REGION:$INSTANCE_NAME" &
PROXY_PID=$!
sleep 5  # Wait for proxy to initialize

# Run the SQL file
PGPASSWORD="$PASSWORD" psql \
  "host=$HOST port=$PORT dbname=$DB_NAME user=$DB_USER sslmode=disable" \
  -f "$SQL_FILE"

if [ $? -eq 0 ]; then
    echo "DDL created Successfully."
else
    echo "Error, DDL not created. hence exiting."
    exit 1
fi