#!/bin/bash
. /home/deepak_kumar214e17/alloydb_gc/agentic/script/agentic_config.param
echo "creating new VM instance agent-my-vw"
set -x

echo "${INSTANCE_NAME}"
echo "${ZONE_NAME}"
echo "${MACHINE_NAME}"
echo "${IMAGE_FAMILY}"
echo "${IMAGE_PROJECT}"
echo "${TAG}"
echo "${SCOPES}"

gcloud config set account "${ACCOUNT}"
# Check if virtual intances exists and is running
VM_STATUS=$(gcloud compute instances describe "$INSTANCE_NAME" --zone="$ZONE_NAME" --format='get(status)' 2>/dev/null)
echo $VM_STATUS

if [[ "$VM_STATUS" == "RUNNING" ]]; then
  echo "VM $INSTANCE_NAME is already running. Continuing..."
else
  echo "VM $INSTANCE_NAME is not running. Creating VM..."

#to create new virtual instance
 gcloud compute instances create "${INSTANCE_NAME}" \
   --zone="${ZONE_NAME}" \
   --machine-type="${MACHINE_NAME}" \
   --image-family="${IMAGE_FAMILY}" \
   --image-project="${IMAGE_PROJECT}" \
   --tags="${TAG}" \
   --scopes="${SCOPES}"
fi

if [ $? -eq 0 ]; then
    echo "virtual instance created successfully."
else
    echo "Error while creating virtual instance. Exiting."
    exit 1
fi
sleep 20 
SCRIPT_FILES=("agentic_config.param" "agentic_alloydb_create_ddl.sh" "agentic_alloydb_create_table.sql")
#USERNAME="deepak_kumar214e17"
TGT_PATH="/home/${USERNAME}/"
SRC_PATH="/home/${USERNAME}/alloydb_gc/agentic/script/"
for FILE in "${SCRIPT_FILES[@]}"; 
do
 echo "copying $SRC_PATH$FILE"
gcloud compute scp "${SRC_PATH}""${FILE}" "${USERNAME}"@"${INSTANCE_NAME}":"${TGT_PATH}" --zone="${ZONE_NAME}"
done

echo "files copied from local_machine to VM"

echo "DDL created for retail dataset"

gcloud compute ssh "${INSTANCE_NAME}" --zone="${ZONE_NAME}" --command="bash "${TGT_PATH}"agentic_alloydb_create_ddl.sh"

if [ $? -eq 0 ]; then
    echo "EDA retail DDL  created successfully in AlloyDB."
else
    echo "Error creating DDL in AlloyDB. Exiting."
    exit 1
fi