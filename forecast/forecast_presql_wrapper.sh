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
. ./forecast_config.param
# --- Configuration ---

# Export password for psql
export PGPASSWORD=$PASSWORD

REMOTE_ALLOYDB_IP="$1"
echo "AlloyDB Primary Instance IP: $REMOTE_ALLOYDB_IP"

psql --version

#psql -h "${REMOTE_ALLOYDB_IP}" -p $PORT -U $USER -d $DATABASE_NAME -f $SQL_FILE

psql \
  -h "${REMOTE_ALLOYDB_IP}" \
  -p "${PORT}" \
  -U "${USER}" \
  -d "${DATABASE_NAME}" \
  --set=ON_ERROR_STOP=1 \
  --set=schema_name="${SCHEMA_NAME}" \
  --file="${PRE_SQL_FILE}"



echo "DDL execution completed successfully."