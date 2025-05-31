#!/bin/bash

# Set variables
CLUSTER_NAME="gke-deep-dive"
REGION="us-west1-a"
NODE_POOL_NAME="gke-node-pool"

echo "Step 1: Creating a cluster without autoscaling..."
gcloud container clusters create $CLUSTER_NAME \
    --region=$REGION \
    --disk-type=pd-standard \
    --disk-size=12 \
    --num-nodes=1

echo "Step 2: Adding a node pool with autoscaling..."
gcloud container node-pools create $NODE_POOL_NAME \
    --cluster=$CLUSTER_NAME \
    --enable-autoscaling \
    --max-nodes=2 \
    --region=$REGION \
    --disk-type=pd-standard \
    --disk-size=10

echo "Step 3: Verifying autoscaling for the node pool..."
gcloud container node-pools describe $NODE_POOL_NAME \
    --cluster=$CLUSTER_NAME \
    --region=$REGION | grep autoscaling -A 1

# Optional Step: Disable autoscaling (uncomment if needed)
# echo "Step 4: Disabling autoscaling..."
# gcloud container clusters update $CLUSTER_NAME \
#     --no-enable-autoscaling \
#     --node-pool=$NODE_POOL_NAME \
#     --region=$REGION

echo "Done!"
