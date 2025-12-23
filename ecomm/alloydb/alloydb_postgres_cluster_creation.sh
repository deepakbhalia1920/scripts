#!/bin/bash
# Script Name: alloydb_postgres_cluster_creation.sh
# Purpose: Automates creation of AlloyDB cluster and primary instance in Google Cloud.
# Prerequisites: gcloud CLI installed and authenticated.

# --- Configuration Variables (Update these as needed) ---
. /home/deepak_kumar214e17/alloydb_gc/ecomm/script/fashion_config.param
#PROJECT_ID="cog01k76j1fr1385r4k0300aq7hxg" # GCP Project ID
#REGION="us-central1" # Region where AlloyDB cluster will be created
#CLUSTER_ID="alloydb-dev-cluster-new" # Name of the AlloyDB cluster
#INSTANCE_ID="alloydb-dev-primary-new" # Name of the primary instance
#DB_PASSWORD="AlloyDB_Dev" # Password for the default database user
#MACHINE_TYPE="n2-highmem-2" # Machine type for the instance
#NETWORK_NAME="alloydb-network" # VPC network name
#ACCOUNT="deepak.kumar214e17@cognizant.com" # GCP account to use

# Display configuration for verification
echo $PROJECT_ID
echo $REGION
echo $CLUSTER_ID

# --- Authenticate and Set Project ---
echo "Authenticating to Google Cloud..."
#gcloud auth login --no-launch-browser # Use --no-launch-browser for scripting
gcloud config set account "${ACCOUNT}"
gcloud config set project "${PROJECT_ID}"


# --- Create AlloyDB Cluster ---
echo "Creating AlloyDB cluster: ${CLUSTER_ID} in ${REGION}..."
gcloud alloydb clusters create "${CLUSTER_ID}" \
    --region="${REGION}" \
    --network="projects/${PROJECT_ID}/global/networks/default" \
    --password="${DB_PASSWORD}" \
    --database-version=POSTGRES_14

# Check if cluster creation succeeded
if [ $? -eq 0 ]; then
    echo "AlloyDB cluster '${CLUSTER_ID}' created successfully."
else
    echo "Error creating AlloyDB cluster '${CLUSTER_ID}'. Exiting."
    exit 1
fi

# --- Create Primary Instance ---
echo "Creating primary instance: ${INSTANCE_ID} in cluster ${CLUSTER_ID}..."
gcloud alloydb instances create "${INSTANCE_ID}" \
    --cluster="${CLUSTER_ID}" \
    --region="${REGION}" \
    --instance-type=PRIMARY \
    --machine-type="${MACHINE_TYPE}" \
    --database-flags="alloydb_ai_nl.enabled=on,alloydb.iam_authentication=on,google_ml_integration.enable_model_support=on,password.enforce_complexity=on" \
    --availability-type=REGIONAL # Use REGIONAL for HA, ZONAL for basic instance

# Check if instance creation succeeded
if [ $? -eq 0 ]; then
    echo "AlloyDB primary instance '${INSTANCE_ID}' created successfully."
else
    echo "Error creating primary instance '${INSTANCE_ID}'. Exiting."
    exit 1
fi

echo "AlloyDB cluster and primary instance creation script completed."