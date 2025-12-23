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
. /home/deepak_kumar214e17/cloudsql_gc/ecomm/script/fashion_config.param
# --------------------------- Configuration -----------------------------------
#REPO_URL="https://github.com/deepakbhalia1920/srcdump.git" # Source repo URL
#CLONE_DIR="raw_dataset" # Local repo directory
#CLONE_DIR_ECOMM="/home/deepak_kumar214e17/raw_dataset/Ecommerce/dataset"
# Target GCS bucket/folder (must exist or gsutil should have permissions to create)
#BUCKET_NAME="gs://alloydb-gc-usecase-newsetup/raw/ecomm/"
#BUCKET_NAME="gs://alloydb-gc-usecase/search-usecase/"
#FOLDER_TO_UPLOAD="load_data*.sh"  # relative path inside repo
#HOMEDIR="/home/deepak_kumar214e17" # Your home directory

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
#FILES_TO_UPLOAD=(*ecommerce*)
#echo "${FILES_TO_UPLOAD[@]}"

FILES_TO_UPLOAD="${FILES_TO_UPLOAD}"
echo "${FILES_TO_UPLOAD}"

# ------------------------- Clean the CSV (no header) --------------------------
# Remove the first line (header) safely into a temp file, then replace original.
# This makes the dataset ready for downstream ingestion steps that expect no header.


chmod 777 "${FILES_TO_UPLOAD}"
wc -l "${FILES_TO_UPLOAD}"
sed '1d' "$FILES_TO_UPLOAD" > tmp_fashion.csv
wc -l tmp_fashion.csv
mv tmp_fashion.csv "$FILES_TO_UPLOAD"
chmod 777 "${FILES_TO_UPLOAD}"
wc -l "${FILES_TO_UPLOAD}"


#sed '1d' "${FILE_NAME}" > "${FILE_NAME}"
#chmod 777 "${FILE_NAME}"

# Upload to GCS
#gsutil -m cp "$HOMEDIR/$CLONE_DIR/${FILES_TO_UPLOAD[@]}" "$BUCKET_NAME"
#gsutil -m cp "${FILES_TO_UPLOAD[@]}" "$BUCKET_NAME"

gsutil -m cp "${FILES_TO_UPLOAD}" "$BUCKET_NAME"

# Upload to GCS
#gsutil -m cp -r "$HOMEDIR/$CLONE_DIR/$FOLDER_TO_UPLOAD" "$BUCKET_NAME"

if [ $? -eq 0 ]; then
    echo "File moved to GCS bucket successfully."
else
    echo "Error file not moved to GCS location. hence exiting."
    exit 1
fi