#!/bin/bash
# --- Configuration Variables (Update these as needed) ---
export PROJECT_ID="dotengage"  # GCP Project ID
export REGION="us-central1"  # Region where AlloyDB cluster will be created
export CLUSTER_ID="alloydb-dev-cluster-new" # Name of the AlloyDB cluster
export INSTANCE_ID="alloydb-dev-primary-new"  # Name of the primary instance
export DB_PASSWORD="AlloyDB_Dev" # Password for the default database user
export MACHINE_TYPE="n2-highmem-2" # Machine type for the instance
export NETWORK_NAME="alloydb-network"  # VPC network name
export ACCOUNT="deepak.kumar214e17@cognizant.com" # GCP account to use


# --------------------------- VM Configuration ---------------------------------
export INSTANCE_NAME="agent-my-vm-test16" # Compute Engine instance name
export ZONE_NAME="us-central1-a" # Zone for VM
export MACHINE_NAME="e2-medium" # Machine type
export IMAGE_FAMILY="debian-11" # OS image family
export IMAGE_PROJECT="debian-cloud"  # OS image project
export TAG="ssh-access"
export SCOPES="https://www.googleapis.com/auth/cloud-platform"
# --------------------------- Account / Project --------------------------------
# VPC and Subnet details (update these as per your environment)
export VPC_NAME="default" # Target VPC network
export SUBNET_NAME="default"  # Target subnet within VPC
export ALLOYDB_PORT=5432

# --- wraper Configuration ---
export DATABASE_NAME="postgres"  # Target database
export SQL_FILE="multimodel_create_table.sql" # SQL file to execute
export BUCKET="gs://alloydb-usecase/uploads"
export USER="postgres" # Database user
export USERNAME="deepak_kumar214e17"
export SCHEMA_NAME="alloydb_usecase"