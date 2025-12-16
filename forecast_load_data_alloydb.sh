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


# --------------------------- Configuration -----------------------------------
echo "Forecast data loading started"

REGION="us-central1" # AlloyDB region
DB="postgres" # Target database
USER_NM="postgres" # Database user
# Destination tables (schema.table)
STORE_TABLE="alloydb_demo.forecast_store"  # Store-level data table
#BUCKET="gs://alloydb-gc-usecase/uploads/"
# GCS bucket/prefix where the CSVs are stored
BUCKET="gs://alloydb-gc-usecase-newsetup/raw/forecast/"
echo "${BUCKET}"
# File names (inside the BUCKET prefix) that should exist in GCS
STORE_FILENAME="forecast_store.csv" #Store csv
echo "${STORE_FILENAME}"
TRAIN_FILENAME="forecast_train.csv" #Train csv
echo "${TRAIN_FILENAME}"
TRAIN_TABLE="alloydb_demo.forecast_train" # Training set table 
echo "${TRAIN_TABLE}"
CLUSTER_NM="alloydb-dev-cluster-new"
TEST_FILENAME="forecast_test.csv"
echo "${TEST_FILENAME}"
TEST_TABLE="alloydb_demo.forecast_test" # Test set table
echo "${TEST_TABLE}"




#gsutil cp emp_temp_data.csv gs://alloydb-usecase/uploads/emp_temp_data.csv
# ----------------------------- Import: Store ---------------------------------
gcloud alloydb clusters import "${CLUSTER_NM}" \
--region="${REGION}" \
--gcs-uri="${BUCKET}""${STORE_FILENAME}" \
--database="${DB}" \
--user="${USER_NM}" \
--csv \
--table="${STORE_TABLE}"

if [[ $? -ne 0 ]]; then
  echo "ERROR: Store data import failed. Exiting."
  exit 1
fi


echo "Train data loading started"
# ----------------------------- Import: Train ---------------------------------
gcloud alloydb clusters import "${CLUSTER_NM}" \
--region="${REGION}" \
--gcs-uri="${BUCKET}""${TRAIN_FILENAME}" \
--database="${DB}" \
--user="${USER_NM}" \
--csv \
--table="${TRAIN_TABLE}"

if [[ $? -ne 0 ]]; then
  echo "ERROR: Train data import failed. Exiting."
  exit 1
fi


# ----------------------------- Import: Test ---------------------------------
gcloud alloydb clusters import "${CLUSTER_NM}" \
--region="${REGION}" \
--gcs-uri="${BUCKET}""${TEST_FILENAME}" \
--database="${DB}" \
--user="${USER_NM}" \
--csv \
--table="${TEST_TABLE}"

if [[ $? -ne 0 ]]; then
  echo "ERROR: Test data import failed. Exiting."
  exit 1
fi
echo "Test data loaded successfully"