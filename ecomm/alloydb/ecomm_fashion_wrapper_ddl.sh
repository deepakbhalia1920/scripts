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
# --------------------------- Configuration -----------------------------------

#PROJECT_ID="cog01k76j1fr1385r4k0300aq7hxg" # GCP Project ID
#REGION="us-central1" # AlloyDB region
#CLUSTER_ID="aia-alloydb"
#INSTANCE_ID="aia-alloydb-primary"
# Static connectivity settings (use either HOST=... or dynamic IP lookup below)
#HOST="10.0.0.11" # AlloyDB private IP (if known)
#PORT="5432" # Postgres port
#DATABASE_NAME="postgres"  # Target database
#SQL_FILE="ecomm_fashion_ddl.sql" # SQL file to execute
#BUCKET="gs://alloydb-gc-usecase/uploads"
#USER="postgres" # Database user
#PASSWORD="AlloyDB_Dev" # Database password
# gcloud account/project 
#ACCOUNT="deepak.kumar214e17@cognizant.com"
#PROJECT_NAME="cog01k76j1fr1385r4k0300aq7hxg"


echo "${SQL_FILE}"
# Export password for psql
export PGPASSWORD=$PASSWORD

# AlloyDB identifiers (optional, used for dynamic IP retrieval)
#ALLOYDB_CLUSTER_ID="alloydb-dev-cluster-new"
#ALLOYDB_PRIMARY_INSTANCE_ID="alloydb-dev-primary-new"
#ALLOYDB_REGION="us-central1"

gcloud config set account ${ACCOUNT}
gcloud config set project ${PROJECT_ID}

#ALLOYDB_IP=$(gcloud alloydb instances describe ${ALLOYDB_PRIMARY_INSTANCE_ID} \
#    --cluster=${ALLOYDB_CLUSTER_ID} \
#    --region=${ALLOYDB_REGION} \
#    --format="value(ipAddress)") # Or value(networkConfig.privateIpAddress) if that's what worked

#echo "${ALLOYDB_IP}"
#if [ -z "$ALLOYDB_IP" ]; then
#    echo "Error: Could not retrieve AlloyDB IP address. Exiting."
#    exit 1
#fi
REMOTE_ALLOYDB_IP="$1"
echo "AlloyDB Primary Instance IP: $REMOTE_ALLOYDB_IP"

# SQL to create table
###need to uncomment below statements
sudo apt install postgresql-client -y
psql --version

psql -h "${REMOTE_ALLOYDB_IP}" -p $ALLOYDB_PORT -U $USER -d $DATABASE_NAME -f ${SQL_FILE}