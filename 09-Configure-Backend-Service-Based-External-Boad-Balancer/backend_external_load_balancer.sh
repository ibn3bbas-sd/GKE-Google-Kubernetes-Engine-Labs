#!/bin/bash

# Set variables
CLUSTER_NAME="gke-deep-dive"
SUBNET_NAME="gke-deep-dive-subnet"
VPC_NAME="default"
REGION="us-central1"

echo "Step 1: Verify Google Cloud API"
gcloud services list

echo "Step 2: Login to Cloud Shell (if needed)"
gcloud auth login

echo "Step 3: Create subnet in default VPC"
gcloud compute networks subnets create $SUBNET_NAME \
    --network=$VPC_NAME \
    --range=10.10.0.0/24 \
    --region=$REGION

echo "Step 4: Verify the network and subnet"
gcloud compute networks subnets describe $SUBNET_NAME --region=$REGION

echo "Step 5: Create VPC native cluster"
gcloud container clusters create $CLUSTER_NAME \
    --num-nodes=1 \
    --disk-type=pd-standard \
    --disk-size=12 \
    --enable-ip-alias \
    --subnetwork=$SUBNET_NAME \
    --addons=HttpLoadBalancing

echo "Step 6: Verify secondary IP ranges"
gcloud compute networks subnets describe $SUBNET_NAME --region=$REGION

echo "Step 7: Check if HttpLoadBalancing add-on is enabled"
gcloud container clusters describe $CLUSTER_NAME --region=$REGION

echo "Step 8: Enable HttpLoadBalancing if needed"
gcloud container clusters update $CLUSTER_NAME \
    --update-addons=HttpLoadBalancing=ENABLED

echo "Step 9: Deploy application"
kubectl apply -f gke-deep-dive-app.yaml

echo "Step 10: Verify pods"
kubectl get pods

echo "Step 11: Deploy service"
kubectl apply -f gke-deep-dive-svc.yaml

echo "Step 12: Get service details"
kubectl get svc gke-deep-dive-svc

echo "Deployment complete. Check EXTERNAL_IP and test using curl."
