#!/bin/bash
# -----------------------------------------------------------------------------
# Script: medical_create_wrapper_ddl.sh
# Purpose: Execute a parameterized SQL file against an AlloyDB instance using psql.
# Usage:
#   ./medical_create_wrapper_ddl.sh
. ./medical_config.sh

# Export password for psql
export PGPASSWORD=$PASSWORD

REMOTE_ALLOYDB_IP="$1"
echo "AlloyDB Primary Instance IP: $REMOTE_ALLOYDB_IP"

#echo "AlloyDB Primary Instance IP: ${ALLOYDB_IP}"

sudo apt install postgresql-client -y
psql --version

#psql -h "${REMOTE_ALLOYDB_IP}" -p $ALLOYDB_PORT -U $USER -d $DATABASE_NAME -f $SQL_FILE

psql \
  -h "${REMOTE_ALLOYDB_IP}" \
  -p "${ALLOYDB_PORT}" \
  -U "${USER}" \
  -d "${DATABASE_NAME}" \
  --set=ON_ERROR_STOP=1 \
  --set=schema_name="${SCHEMA_NAME}" \
  --file="${SQL_FILE}"