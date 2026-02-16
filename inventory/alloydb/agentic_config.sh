#!/bin/bash
# --- Configuration Variables (Update these as needed) ---
export INVENTORY_CONFIG="~/alloydb/agentic/script/agentic_config.param"
export PROJECT_ID="dotengage" # GCP Project ID
export REGION="us-central1" # Region where AlloyDB cluster will be created
export CLUSTER_ID="alloydb-dev-cluster-new" # Name of the AlloyDB cluster
export INSTANCE_ID="alloydb-dev-primary-new"  # Name of the primary instance
export DB_PASSWORD="AlloyDB_Dev" # Password for the default database user
export MACHINE_TYPE="n2-highmem-2" # Machine type for the instance
export NETWORK_NAME="alloydb-network"  # VPC network name
export ACCOUNT="deepak.kumar214e17@cognizant.com" # GCP account to use

########################
#echo "creating new VM instance agent-my-vw"
#set -x
export INSTANCE_NAME="agent-my-vm-test16"
export ZONE_NAME="us-central1-a"
export MACHINE_NAME="e2-medium"
export IMAGE_FAMILY="debian-11"
export IMAGE_PROJECT="debian-cloud"
export TAG="ssh-access"
export SCOPES="https://www.googleapis.com/auth/cloud-platform"
# --- Configuration ---
export HOST="10.0.0.11"
export PORT="5432"
export DATABASE_NAME="postgres"
export SQL_FILE="agentic_alloydb_create_table.sql"
export BUCKET="gs://alloydb-usecase/uploads"
export USER="postgres"
export PASSWORD="AlloyDB_Dev"
export USERNAME="deepak_kumar214e17"
export SCHEMA_NAME="alloydb_usecase"
export PRIMARY_INSTANCE_ID="alloydb-dev-primary-new"
export SRC_AGENT="/home/deepak_kumar214e17/alloydb/agentic/script/"