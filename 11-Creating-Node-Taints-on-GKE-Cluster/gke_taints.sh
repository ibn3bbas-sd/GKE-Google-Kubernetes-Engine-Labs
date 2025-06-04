#!/bin/bash

# Setup GKE cluster with node taints
CLUSTER_NAME="gke-deep-dive"
ZONE="us-central1-a"
PROJECT_ID="$(gcloud config get-value project)"

echo "Creating cluster with initial taints..."
gcloud container clusters create "$CLUSTER_NAME" \
  --num-nodes=1 \
  --disk-type=pd-standard \
  --disk-size=10 \
  --node-taints=function=research:PreferNoSchedule \
  --zone="$ZONE"

echo "Creating a taint-free node pool..."
gcloud container node-pools create gke-deep-dive-pool \
  --num-nodes=1 \
  --disk-type=pd-standard \
  --disk-size=10 \
  --cluster="$CLUSTER_NAME" \
  --zone="$ZONE"

echo "Updating node pool with taint..."
gcloud beta container node-pools update gke-deep-dive-pool \
  --node-taints=function=shared:NoSchedule \
  --cluster="$CLUSTER_NAME" \
  --zone="$ZONE"

echo "Creating a dedicated node pool with a taint..."
gcloud container node-pools create gke-deep-dive-pool-dedicated \
  --num-nodes=1 \
  --disk-type=pd-standard \
  --disk-size=10 \
  --cluster="$CLUSTER_NAME" \
  --node-taints=dedicated=development:NoExecute \
  --zone="$ZONE"

echo "Updating default node pool taint..."
gcloud beta container node-pools update default-pool \
  --node-taints=function=research:NoSchedule \
  --cluster="$CLUSTER_NAME" \
  --zone="$ZONE"

echo "Cluster and node pools configured."

 # Clean up resources
echo "Cleaning up resources..."
gcloud container clusters delete "$CLUSTER_NAME" --zone="$ZONE" --quiet