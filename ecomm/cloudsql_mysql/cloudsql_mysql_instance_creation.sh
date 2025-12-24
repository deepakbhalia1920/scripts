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
. /home/deepak_kumar214e17/mysql_gc/ecomm/script/fashion_config.param

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