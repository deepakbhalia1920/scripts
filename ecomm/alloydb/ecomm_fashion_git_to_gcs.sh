#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : ecomm_fashion_git_to_gcs.sh
# Purpose     : Pull latest dataset from a Git repo and upload the cleaned CSV
#               (header removed) to a GCS bucket.
#
# Prerequisites:
#   - git and gsutil installed & authenticated (gcloud auth login / ADC for gsutil)
#   - Read access to the Git repository
#   - Write access to the target GCS bucket
# -----------------------------------------------------------------------------
. /home/deepak_kumar214e17/alloydb_gc/ecomm/script/fashion_config.param

# Clone the repo
echo "copying the file from gitrepo to gcs bucket"
#git clone "$REPO_URL" "$CLONE_DIR"

# Expand wildcard into array

# Set permissions
cd "$HOMEDIR/$CLONE_DIR"
git pull
sleep 5
echo "${CLONE_DIR_ECOMM}"
cd "${CLONE_DIR_ECOMM}"

FILES_TO_UPLOAD="${FILES_TO_UPLOAD}"
echo "${FILES_TO_UPLOAD}"

chmod 777 "${FILES_TO_UPLOAD}"
wc -l "${FILES_TO_UPLOAD}"
sed '1d' "$FILES_TO_UPLOAD" > tmp_fashion.csv
wc -l tmp_fashion.csv
mv tmp_fashion.csv "$FILES_TO_UPLOAD"
chmod 777 "${FILES_TO_UPLOAD}"
wc -l "${FILES_TO_UPLOAD}"

gsutil -m cp "${FILES_TO_UPLOAD}" "$BUCKET_NAME"

# Upload to GCS

if [ $? -eq 0 ]; then
    echo "File moved to GCS bucket successfully."
else
    echo "Error file not moved to GCS location. hence exiting."
    exit 1
fi