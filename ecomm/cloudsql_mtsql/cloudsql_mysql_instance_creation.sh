#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : cloudsql_mysql_instance_creation.sh
# Purpose     : Creates a Google Cloud SQL for MySQL instance (idempotent),
#               enables Google ML integration and selected database flags.
#
# Prerequisites:
#   - gcloud CLI installed and authenticated (gcloud auth login or ADC)
#   - Roles: Cloud SQL Admin (roles/cloudsql.admin) on target project
#   - Quotas for chosen tier/region; MySQL 8.0 supported in the region
# -----------------------------------------------------------------------------

# --------------------------- Configuration -----------------------------------

PROJECT_ID="cog01k76j1fr1385r4k0300aq7hxg" # GCP Project ID
INSTANCE_NAME="cloudsql-mysql-gc-instance" # Cloud SQL instance name (global)
REGION="us-central1" # Region for the instance
#TIER="db-f1-micro"            # choose a tier to match workload
TIER="db-custom-2-8192" # Choose a tier to match workload; db-custom-2-8192 ≈ 2 vCPU / 8 GB RAM
ROOT_PASSWORD="Mysql@dev1" # initial root password
DATABASE_VERSION="MYSQL_8_0" # MySQL major version

# If you prefer Private IP only, set PRIVATE_ONLY=true and provide VPC self-link
PRIVATE_ONLY=false
VPC_SELF_LINK=""  # e.g. "projects/${PROJECT_ID}/global/networks/default"

# --- Set the project ---
gcloud config set project "$PROJECT_ID"

# --- Check instance existence/state (idempotent) ---
SQL_STATUS=$(gcloud sql instances describe "$INSTANCE_NAME" --project="$PROJECT_ID" --format="value(state)" 2>/dev/null)
if [[ "$SQL_STATUS" == "RUNNABLE" || "$SQL_STATUS" == "PENDING_CREATE" ]]; then
  echo "Cloud SQL instance '$INSTANCE_NAME' already exists and is in state: $SQL_STATUS. Skipping creation."
else
  echo "Creating Cloud SQL MySQL instance '$INSTANCE_NAME' in $REGION ..."

  # Build base create command
   gcloud sql instances create "$INSTANCE_NAME" \
   --database-version="$DATABASE_VERSION" \
   --tier="$TIER" \
   --region="$REGION" \
   --root-password="$ROOT_PASSWORD" \
   --enable-google-ml-integration \
   --database-flags="sql_mode=STRICT_TRANS_TABLES,activate_all_roles_on_login=on"
fi

gcloud sql instances patch "$INSTANCE_NAME" \
  --database-flags=cloudsql_vector=on
sleep 20