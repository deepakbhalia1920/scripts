#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : forecast_load_data_alloydb.sh
# Purpose     : Load store, train, and test CSV files from a GCS bucket into
#               AlloyDB tables using `gcloud alloydb clusters import`.
#
# Prerequisites:
#   - gcloud CLI installed and authenticated (gcloud auth login / ADC)
#   - Caller has:
#       * Storage permissions to read the GCS objects
#       * AlloyDB permissions to import data into the cluster
#   - The CSV files exist at the specified GCS URIs
#   - Target database & tables exist in AlloyDB (schema must match CSVs)
# -----------------------------------------------------------------------------
. "$FORECAST_CONFIG"
# --------------------------- Configuration -----------------------------------
echo "Forecast data loading started"
BUCKET_NAME="${BUCKET_NAME}"
echo "${BUCKET_NAME}"
BUCKET="${BUCKET}"
echo "${BUCKET}"
# File names (inside the BUCKET prefix) that should exist in GCS
STORE_FILENAME="${STORE_FILENAME}" #Store csv
echo "${STORE_FILENAME}"
TRAIN_FILENAME="${TRAIN_FILENAME}" #Train csv
echo "${TRAIN_FILENAME}"
######TRAIN_TABLE="${TRAIN_TABLE}" # Training set table 
######echo "${TRAIN_TABLE}"
#CLUSTER_ID="alloydb-dev-cluster-new"
TEST_FILENAME="${TEST_FILENAME}"
echo "${TEST_FILENAME}"
########TEST_TABLE="${TEST_TABLE}" # Test set table
########echo "${TEST_TABLE}"

PROJECT_NUMBER=$(gcloud projects describe "$PROJECT_ID" --format="value(projectNumber)")
echo "${PROJECT_NUMBER}"
SA_EMAIL="service-${PROJECT_NUMBER}@gcp-sa-alloydb.iam.gserviceaccount.com"
echo "${SA_EMAIL}"
echo "Granting Storage permissions to AlloyDB service account: $SA_EMAIL"

gcloud storage buckets add-iam-policy-binding "gs://${BUCKET_NAME}" \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/storage.objectViewer"


#gsutil cp emp_temp_data.csv gs://alloydb-usecase/uploads/emp_temp_data.csv
# ----------------------------- Import: Store ---------------------------------
gcloud alloydb clusters import "${CLUSTER_ID}" \
--region="${REGION}" \
--gcs-uri="${BUCKET}""${STORE_FILENAME}" \
--database="${DATABASE_NAME}" \
--user="${USER}" \
--csv \
--table="${SCHEMA_NAME}.forecast_store"

if [[ $? -ne 0 ]]; then
  echo "ERROR: Store data import failed. Exiting."
  exit 1
fi


echo "Train data loading started"
# ----------------------------- Import: Train ---------------------------------
gcloud alloydb clusters import "${CLUSTER_ID}" \
--region="${REGION}" \
--gcs-uri="${BUCKET}""${TRAIN_FILENAME}" \
--database="${DATABASE_NAME}" \
--user="${USER}" \
--csv \
--table="${SCHEMA_NAME}.forecast_train"

if [[ $? -ne 0 ]]; then
  echo "ERROR: Train data import failed. Exiting."
  exit 1
fi


# ----------------------------- Import: Test ---------------------------------
gcloud alloydb clusters import "${CLUSTER_ID}" \
--region="${REGION}" \
--gcs-uri="${BUCKET}""${TEST_FILENAME}" \
--database="${DATABASE_NAME}" \
--user="${USER}" \
--csv \
--table="${SCHEMA_NAME}.forecast_test"

if [[ $? -ne 0 ]]; then
  echo "ERROR: Test data import failed. Exiting."
  exit 1
fi
echo "Test data loaded successfully"