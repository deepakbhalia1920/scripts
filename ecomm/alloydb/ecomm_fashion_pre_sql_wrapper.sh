#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : ecomm_fashion_pre_sql_wrapper.sh
# Purpose     : Execute pre-setup SQL/DDL statements in a .sql file against an
#               AlloyDB (PostgreSQL) instance using psql.
#
# Prerequisites:
#   - VM/host has network reachability to AlloyDB (Private IP, firewall for TCP 5432)
#   - 'postgresql-client' available (script installs it if missing)
#   - The SQL file exists in the working directory or given path
# -----------------------------------------------------------------------------
. /home/deepak_kumar214e17/fashion_config.param

# Export password for psql
export PGPASSWORD=$PASSWORD
REMOTE_ALLOYDB_IP="$1"
echo "AlloyDB Primary Instance IP: $REMOTE_ALLOYDB_IP"

# SQL to create table
sudo apt install postgresql-client -y
psql --version

psql -h $REMOTE_ALLOYDB_IP -p $ALLOYDB_PORT -U $USER -d $DATABASE_NAME -f $PRE_SQL_FILE

echo "Pre-setup SQL executed successfully."