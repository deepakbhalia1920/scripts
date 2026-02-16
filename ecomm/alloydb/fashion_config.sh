#!/bin/bash
# --- Configuration Variables (Update these as needed) ---
#export FASHION_CONFIG="/home/deepak_kumar214e17/alloydb/ecomm/script/fashion_config.param"

export PROJECT_ID="dotengage" # GCP Project ID
export REGION="us-central1" # Region where AlloyDB cluster will be created
export CLUSTER_ID="alloydb-dev-cluster-new" # Name of the AlloyDB cluster
export INSTANCE_ID="alloydb-dev-primary-new" # Name of the primary instance
export DB_PASSWORD="AlloyDB_Dev" # Password for the default database user
export MACHINE_TYPE="n2-highmem-2" # Machine type for the instance
export NETWORK_NAME="alloydb-network" # VPC network name
export ACCOUNT="deepak.kumar214e17@cognizant.com" # GCP account to use

# --------------------------- Git Configuration -----------------------------------
export REPO_URL="https://github.com/deepakbhalia1920/srcdump.git" # Source repo URL
export CLONE_DIR="raw_dataset" # Local repo directory
export CLONE_DIR_ECOMM="/home/deepak_kumar214e17/raw_dataset/Ecommerce/dataset"
# Target GCS bucket/folder (must exist or gsutil should have permissions to create)
export BUCKET_NAME="gs://alloydb-gc-usecase-newsetup/raw/ecomm/"
#BUCKET_NAME="gs://alloydb-gc-usecase/search-usecase/"
#FOLDER_TO_UPLOAD="load_data*.sh"  # relative path inside repo
export HOMEDIR="/home/deepak_kumar214e17" # Your home directory

export FILES_TO_UPLOAD="fashion_dataset.csv"
# --------------------------- VM Configuration ---------------------------------
export PRIMARY_INSTANCE_ID="alloydb-dev-primary-new"
export INSTANCE_NAME="agent-my-vm-test16" # Compute Engine instance name
export ZONE_NAME="us-central1-a" # Zone for VM
export MACHINE_NAME="e2-medium" # Machine type
export IMAGE_FAMILY="debian-11" # OS image family
export IMAGE_PROJECT="debian-cloud"  # OS image project
export TAG="ssh-access" # Network tag used for firewall targeting
export SCOPES="https://www.googleapis.com/auth/cloud-platform" # Broad scope (consider least-privilege SA)
# --------------------------- Account / Project --------------------------------
export VPC_NAME="default" # Target VPC network
export SUBNET_NAME="default" # Target subnet within VPC
export ALLOYDB_PORT=5432

#########
export DATABASE_NAME="postgres"  # Target database
export SQL_FILE="ecomm_fashion_ddl.sql" # SQL file to execute
export USER="postgres" # Database user
export PASSWORD="AlloyDB_Dev" # Database password
# gcloud account/project 
########################################################
# AlloyDB details
export ALLOYDB_HOST="10.123.50.2"
######
export PRE_SQL_FILE="ecomm_fashion_presql.sql"
export USERNAME="deepak_kumar214e17"
################################################
export BUCKET_NAME_ROOT="alloydb-gc-usecase-newsetup"
export ECOMM_TABLE="alloydb_usecase.fashion_products_0120"
export SCHEMA_NAME="alloydb_usecase"
export SRC_ECOMM="/home/deepak_kumar214e17/alloydb/ecomm/script/"
#ECOMM_TABLE_DDL="fashion_products_0120"