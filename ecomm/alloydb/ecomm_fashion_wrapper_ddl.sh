#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : ecomm_fashion_wrapper_ddl.sh
# Purpose     : Execute the DDL statements in a .sql file against an AlloyDB
#               (PostgreSQL) instance using psql.
#
# Prerequisites:
#   - VM/host has network reachability to AlloyDB (Private IP, firewall 5432)
#   - gcloud CLI installed and authenticated (if using dynamic IP discovery)
#   - IAM/permissions to run 'gcloud alloydb' (optional, for IP lookup)
#   - The SQL file exists in the working directory or path provided
# -----------------------------------------------------------------------------
. /home/deepak_kumar214e17/fashion_config.param

echo "${SQL_FILE}"
# Export password for psql
export PGPASSWORD=$PASSWORD

gcloud config set account ${ACCOUNT}
gcloud config set project ${PROJECT_ID}

REMOTE_ALLOYDB_IP="$1"
echo "AlloyDB Primary Instance IP: $REMOTE_ALLOYDB_IP"

# SQL to create table
sudo apt install postgresql-client -y
psql --version

psql -h "${REMOTE_ALLOYDB_IP}" -p $ALLOYDB_PORT -U $USER -d $DATABASE_NAME -f ${SQL_FILE}