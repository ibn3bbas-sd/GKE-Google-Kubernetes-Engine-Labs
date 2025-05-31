#!/bin/bash

# Google Cloud Project Setup
PROJECT_ID="your-project-id"
COMPUTE_ZONE="me-central1-a"
CLUSTER_NAME="gke-deep-dive"

# Set the default project
gcloud config set project $PROJECT_ID

# Set the default compute zone
gcloud config set compute/zone $COMPUTE_ZONE

# Enable GKE API (if not enabled)
gcloud services enable container.googleapis.com

# Create the GKE cluster
echo "Creating GKE cluster: $CLUSTER_NAME..."
gcloud container clusters create $CLUSTER_NAME \
  --num-nodes=1 \
  --disk-type=pd-standard \
  --disk-size=12

echo "Cluster creation in progress... It may take around 10-15 minutes."

# Verify the cluster
echo "Verifying cluster creation..."
gcloud container clusters list

# Multi-zone cluster setup (optional)
MULTI_ZONE="us-west1-a,us-west1-b,us-west1-c"
echo "Creating a multi-zone cluster..."
gcloud container clusters create $CLUSTER_NAME \
  --num-nodes=3 \
  --disk-type=pd-standard \
  --disk-size=12 \
  --zone us-central1-a \
  --node-locations $MULTI_ZONE

# Delete the cluster (optional)
echo "To delete the cluster, run the following command:"
echo "gcloud container clusters delete $CLUSTER_NAME --quiet --zone $COMPUTE_ZONE"

echo "GKE setup completed!"