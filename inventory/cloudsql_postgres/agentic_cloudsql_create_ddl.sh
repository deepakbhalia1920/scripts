#!/bin/bash
# Purpose: Create database objects (DDL) in a Cloud SQL for PostgreSQL instance
#          by executing a local SQL file via the Cloud SQL Auth Proxy.
# Usage:   ./agentic_cloudsql_create_ddl.sh
# Requires:
#   - cloud-sql-proxy available in PATH
#   - psql (PostgreSQL client) installed
#   - gcloud authenticated to the correct project
. /home/deepak_kumar214e17/cloudsql_gc/agentic/script/agentic_config.param

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