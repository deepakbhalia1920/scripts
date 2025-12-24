#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : ecomm_fashion_cloudsql_create_ddl.sh
# Purpose     : Start the Cloud SQL Auth Proxy and execute a DDL SQL file
#               against a Cloud SQL for PostgreSQL instance using psql.
#
# Prerequisites:
#   - Cloud SQL Auth Proxy installed and in PATH (binary: cloud-sql-proxy)
#   - gcloud/ADC credentials with permission to connect to the instance
#   - The SQL file exists and is accessible to this script
#   - Network egress allowed to Cloud SQL endpoints
# -----------------------------------------------------------------------------
. /home/deepak_kumar214e17/cloudsql_gc/ecomm/script/fashion_config.param

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