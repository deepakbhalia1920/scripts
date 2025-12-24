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
PRE_SQL_FILE="${PRE_SQL_FILE}"

# Export password for psql
export PGPASSWORD=$PASSWORD

# Start Cloud SQL Auth Proxy
cloud-sql-proxy "$PROJECT_ID:$REGION:$INSTANCE_NAME" &
PROXY_PID=$!
sleep 5  # Wait for proxy to initialize

# Run the SQL file
PGPASSWORD="$PASSWORD" psql \
  "host=$HOST port=$PORT dbname=$DB_NAME user=$DB_USER sslmode=disable" \
  -f "$PRE_SQL_FILE"

if [ $? -eq 0 ]; then
    echo "PreSql Statement run Successfully."
else
    echo "Error, presql statements not run successfully. hence exiting."
    exit 1
fi