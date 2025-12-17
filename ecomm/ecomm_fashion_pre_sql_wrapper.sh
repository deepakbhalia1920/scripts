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

# --- Configuration ---
PROJECT_ID="dotengage" #GCP Project ID
REGION="us-central1" # AlloyDB region
CLUSTER_ID="aia-alloydb" #  AlloyDB cluster ID
INSTANCE_ID="aia-alloydb-primary" #  AlloyDB instance ID
# Static connectivity settings (update to match your environment)
#HOST="10.0.0.8"
PORT="5432"
# Database login + target DB
DATABASE_NAME="postgres" # Target database
# SQL file to execute
SQL_FILE="ecomm_fashion_presql.sql"
BUCKET="gs://alloydb-usecase/uploads"
USER="postgres" # Database user
PASSWORD="AlloyDB_Dev" # Database password

# Export password for psql
export PGPASSWORD=$PASSWORD
REMOTE_ALLOYDB_IP="$1"
echo "AlloyDB Primary Instance IP: $REMOTE_ALLOYDB_IP"

# SQL to create table
sudo apt install postgresql-client -y
psql --version

psql -h $REMOTE_ALLOYDB_IP -p $PORT -U $USER -d $DATABASE_NAME -f $SQL_FILE

echo "Pre-setup SQL executed successfully."