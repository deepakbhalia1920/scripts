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

# --------------------------- Configuration -----------------------------------
REPO_URL="https://github.com/deepakbhalia1920/srcdump.git" # Source repo URL
CLONE_DIR="raw_dataset"  # Local repo directory
CLONE_DIR_FORECAST="/home/deepak_kumar214e17/raw_dataset/Forecast/dataset"
#BUCKET_NAME="gs://alloydb-gc-usecase/uploads/"
# Target GCS bucket/folder (must exist or gsutil should have permissions to create)
BUCKET_NAME="gs://alloydb-gc-usecase-newsetup/raw/forecast/"
#FOLDER_TO_UPLOAD="load_data*.sh"  # relative path inside repo
HOMEDIR="/home/deepak_kumar214e17"  # Your home directory

# Clone the repo
echo "copying the file from gitrepo to gcs bucket"
#git clone "$REPO_URL" "$CLONE_DIR"

# Set permissions
cd "$HOMEDIR/$CLONE_DIR"
git pull
sleep 5
echo "${CLONE_DIR_FORECAST}"
cd "${CLONE_DIR_FORECAST}"
#FILES_TO_UPLOAD=(*train*)
#FILES_TO_UPLOAD_STORE=(*store*)
#echo "${FILES_TO_UPLOAD[@]}"
#echo "${FILES_TO_UPLOAD_STORE[@]}"

FILES_TO_UPLOAD=forecast_train.csv
FILES_TO_UPLOAD_STORE=forecast_store.csv
FILES_TO_UPLOAD_TEST=forecast_test.csv
echo "${FILES_TO_UPLOAD}"
echo "${FILES_TO_UPLOAD_STORE}"
echo "${FILES_TO_UPLOAD_TEST}"


#sleep 20
#chmod 777 "$HOMEDIR/$CLONE_DIR/${FILES_TO_UPLOAD[@]}"
#chmod 777 "${FILES_TO_UPLOAD[@]}" "${FILES_TO_UPLOAD_STORE[@]}"

#chmod 777 "${FILES_TO_UPLOAD}"
chmod 777 "${FILES_TO_UPLOAD}"
chmod 777 "${FILES_TO_UPLOAD_STORE}"
chmod 777 "${FILES_TO_UPLOAD_TEST}"

wc -l "${FILES_TO_UPLOAD}"
sed '1d' "$FILES_TO_UPLOAD" > tmp_train.csv
wc -l tmp_train.csv
mv tmp_train.csv "$FILES_TO_UPLOAD"
chmod 777 "${FILES_TO_UPLOAD}"
wc -l "${FILES_TO_UPLOAD}"


echo "Store data file header removal"
chmod 777 "${FILES_TO_UPLOAD_STORE}"
wc -l "${FILES_TO_UPLOAD_STORE}"
sed '1d' "$FILES_TO_UPLOAD_STORE" > tmp_store.csv
wc -l tmp_store.csv
mv tmp_store.csv "$FILES_TO_UPLOAD_STORE"
chmod 777 "${FILES_TO_UPLOAD_STORE}"
wc -l "${FILES_TO_UPLOAD_STORE}"

wc -l "${FILES_TO_UPLOAD_TEST}"
sed '1d' "${FILES_TO_UPLOAD_TEST}" > tmp_test.csv
wc -l tmp_test.csv
mv tmp_test.csv "${FILES_TO_UPLOAD_TEST}"
chmod 777 "${FILES_TO_UPLOAD_TEST}"
wc -l "${FILES_TO_UPLOAD_TEST}"


#sed '1d' "${FILES_TO_UPLOAD}" > "${FILES_TO_UPLOAD}"
#chmod 777 "${FILEs_TO_UPLOAD}"
#sed '1d' "${FILES_TO_UPLOAD_STORE}" > "${FILES_TO_UPLOAD_STORE}"
#chmod 777 "${FILEs_TO_UPLOAD_STORE}"


# Upload to GCS
#gsutil -m cp "$HOMEDIR/$CLONE_DIR/${FILES_TO_UPLOAD[@]}" "$BUCKET_NAME"
#gsutil -m cp "${FILES_TO_UPLOAD[@]}" "$BUCKET_NAME"
gsutil -m cp "${FILES_TO_UPLOAD}" "$BUCKET_NAME"


# Upload to GCS
#gsutil -m cp -r "$HOMEDIR/$CLONE_DIR/$FOLDER_TO_UPLOAD" "$BUCKET_NAME"

if [ $? -eq 0 ]; then
    echo "train file moved to GCS bucket successfully."
else
    echo "Error, train file not moved to GCS location. hence exiting."
    exit 1
fi

echo "Store file getting move to gcs bucket"
#gsutil -m cp "${FILES_TO_UPLOAD_STORE[@]}" "$BUCKET_NAME"
gsutil -m cp "${FILES_TO_UPLOAD_STORE}" "$BUCKET_NAME"

if [ $? -eq 0 ]; then
    echo "Store file moved to GCS bucket successfully."
else
    echo "Error, Store file not moved to GCS location. hence exiting."
    exit 1
fi

echo "Test file getting move to gcs bucket"
gsutil -m cp "${FILES_TO_UPLOAD_TEST}" "$BUCKET_NAME"
if [ $? -eq 0 ]; then
    echo "Test file moved to GCS bucket successfully."
else
    echo "Error, Store file not moved to GCS location. hence exiting."
    exit 1
fi