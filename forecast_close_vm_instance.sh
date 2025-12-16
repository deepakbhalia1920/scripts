#!/bin/bash
set -x
INSTANCE_NAME="agent-my-vm-test16"
ZONE_NAME="us-central1-a"
MACHINE_NAME="e2-medium"
IMAGE_FAMILY="debian-11"
IMAGE_PROJECT="debian-cloud"
TAG="ssh-access"
SCOPES="https://www.googleapis.com/auth/cloud-platform"

echo "${INSTANCE_NAME}"
echo "${ZONE_NAME}"
echo "${MACHINE_NAME}"
echo "${IMAGE_FAMILY}"
echo "${IMAGE_PROJECT}"
echo "${TAG}"
echo "${SCOPES}"
gcloud config set account deepak.kumar214e17@cognizant.com

echo "deleting  VM instance $INSTANCE_NAME"

#to delete virtual instance
if gcloud compute instances describe "$INSTANCE_NAME" --zone="$ZONE_NAME" &> /dev/null; then
    echo "Stopping VM..."
    gcloud compute instances stop "$INSTANCE_NAME" --zone="$ZONE_NAME"
        sleep 20
    
    echo "deleting VM..."
    gcloud compute instances delete "$INSTANCE_NAME" --zone="$ZONE_NAME" --quiet
else
    echo "VM $INSTANCE_NAME does not exist in zone $ZONE_NAME."
fi