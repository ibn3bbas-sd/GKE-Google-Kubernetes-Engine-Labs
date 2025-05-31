#!/bin/bash

# Script to manually upgrade a GKE cluster and its node pool

# Variables (update as needed)
CLUSTER_NAME="gke-deep-dive"
REGION="us-west1-a"
NODE_POOL_NAME="default-pool"
TARGET_VERSION="1.32.4-gke.1353000"

echo "Creating GKE cluster..."
gcloud container clusters create $CLUSTER_NAME \
    --region=$REGION \
    --disk-type=pd-standard \
    --disk-size=12 \
    --num-nodes=1

echo "Checking available versions..."
gcloud container get-server-config --zone=$REGION

echo "Upgrading control plane to version $TARGET_VERSION..."
gcloud container clusters upgrade $CLUSTER_NAME \
    --zone=$REGION \
    --master \
    --cluster-version $TARGET_VERSION

echo "Upgrading node pool $NODE_POOL_NAME..."
gcloud container clusters upgrade $CLUSTER_NAME \
    --node-pool=$NODE_POOL_NAME \
    --cluster-version $TARGET_VERSION

echo "Upgrade process completed!"

