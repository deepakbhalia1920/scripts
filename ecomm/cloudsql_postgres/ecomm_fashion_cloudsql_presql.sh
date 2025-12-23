#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : ecomm_fashion_cloudsql_presql.sh
# Purpose     : Start the Cloud SQL Auth Proxy and execute a pre-setup SQL file
#               against a Cloud SQL for PostgreSQL instance using psql.
#
# Prerequisites:
#   - Cloud SQL Auth Proxy installed and in PATH (binary: cloud-sql-proxy)
#   - gcloud/ADC credentials with permission to connect to the instance
#   - The SQL file exists and is accessible to this script
#   - Network egress allowed to Cloud SQL endpoints
# -----------------------------------------------------------------------------


. /home/deepak_kumar214e17/cloudsql_gc/ecomm/script/fashion_config.param
# --- Configuration ---
#PROJECT_ID="cog01k76j1fr1385r4k0300aq7hxg" # GCP Project ID
#REGION="us-central1" # Instance region 
#CLUSTER_ID="aia-alloydb"
#INSTANCE_NAME="cloudsql-postgres-instance-0112" # Cloud SQL instance name
##HOST="127.0.0.1" # Local host
#PORT="5432" # Local port
#DB_NAME="postgres" # Target database
PRE_SQL_FILE="${PRE_SQL_FILE}"
#BUCKET="gs://alloydb-usecase/uploads"
#DB_USER="postgres" # Database user 
#PASSWORD="Cloudsql@dev1"  # Password

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
    echo "PreSql Statement run Successfully."
else
    echo "Error, presql statements not run successfully. hence exiting."
    exit 1
fi