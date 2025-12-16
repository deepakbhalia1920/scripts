#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : forecast_create_ddl.sh
# Purpose     : Execute DDL statements in a .sql file against an AlloyDB
#               (PostgreSQL) instance using psql.
#
# Prerequisites:
#   - VM/host can reach AlloyDB over TCP 5432 (Private IP + firewall/peering)
#   - 'postgresql-client' available (installed below if missing)
#   - SQL file exists and DDL is idempotent (recommended for repeat runs)
# -----------------------------------------------------------------------------

# --- Configuration ---
PROJECT_ID="cog01k76j1fr1385r4k0300aq7hxg" #GCP Project ID
REGION="us-central1" #AlloyDB region
CLUSTER_ID="aia-alloydb"
INSTANCE_ID="aia-alloydb-primary"
#HOST="10.0.0.11"
PORT="5432"  # Postgres port
DATABASE_NAME="postgres"  # Target database
SQL_FILE="forecast_create_table.sql" # SQL file to execute
BUCKET="gs://alloydb-usecase/uploads"
USER="postgres" # Database user
PASSWORD="AlloyDB_Dev" # Password

# Export password for psql
export PGPASSWORD=$PASSWORD

#ALLOYDB_CLUSTER_ID="alloydb-dev-cluster-new"
#ALLOYDB_PRIMARY_INSTANCE_ID="alloydb-dev-primary-new"
#ALLOYDB_REGION="us-central1"

#ALLOYDB_IP=$(gcloud alloydb instances describe ${ALLOYDB_PRIMARY_INSTANCE_ID} \
#    --cluster=${ALLOYDB_CLUSTER_ID} \
#    --region=${ALLOYDB_REGION} \
#    --format="value(ipAddress)") # Or value(networkConfig.privateIpAddress) if that's what worked
REMOTE_ALLOYDB_IP="$1"
echo "AlloyDB Primary Instance IP: $REMOTE_ALLOYDB_IP"

#if [ -z "$ALLOYDB_IP" ]; then
#    echo "Error: Could not retrieve AlloyDB IP address. Exiting."
#    exit 1
#fi

#echo "AlloyDB Primary Instance IP: ${ALLOYDB_IP}"

sudo apt install postgresql-client -y
psql --version

psql -h "${REMOTE_ALLOYDB_IP}" -p $PORT -U $USER -d $DATABASE_NAME -f $SQL_FILE

echo "DDL execution completed successfully."