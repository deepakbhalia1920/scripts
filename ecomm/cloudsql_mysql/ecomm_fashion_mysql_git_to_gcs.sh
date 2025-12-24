#!/bin/bash
# Purpose: Pull fashion ecommerce CSV from a Git repo and upload it to a GCS bucket.
# Usage:   ./ecomm_fashion_mysql_git_to_gcs.sh
# Requires:
#   - git and gsutil installed and on PATH
#   - gcloud/gsutil authenticated with permissions to write to the target bucket
. /home/deepak_kumar214e17/mysql_gc/ecomm/script/fashion_config.param

# Clone the repo
echo "copying the file from gitrepo to gcs bucket"
#git clone "$REPO_URL" "$CLONE_DIR"

# Expand wildcard into array

# Set permissions
cd "$HOMEDIR/$CLONE_DIR"
git pull
sleep 5
echo ""${CLONE_DIR_ECOMM}
cd "${CLONE_DIR_ECOMM}"
#FILES_TO_UPLOAD=(*ecommerce*)
#echo "${FILES_TO_UPLOAD[@]}"

FILES_TO_UPLOAD="${FILES_TO_UPLOAD}" # CSV to process
echo "${FILES_TO_UPLOAD}"

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

if [ $? -eq 0 ]; then
    echo "File moved to GCS bucket successfully."
else
    echo "Error file not moved to GCS location. hence exiting."
    exit 1
fi