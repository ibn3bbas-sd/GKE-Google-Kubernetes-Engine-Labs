#!/bin/bash
# Script to create and manage a VPC-native GKE cluster
# Usage: ./create-vpc-native-cluster.sh [create|describe|delete]

set -e

# Configuration
ZONE="us-west1-a"
REGION="us-west1"
CLUSTER_NAME="gke-deep-dive"
VPC_NAME="gke-deep-dive-vpc"
SUBNET_NAME="gke-deep-dive-vpc-subnet"
SUBNET_RANGE="10.10.0.0/24"
CLUSTER_IPV4_CIDR="/21"
SERVICES_IPV4_CIDR="/21"

function create_resources() {
    echo "Creating VPC network '$VPC_NAME'..."
    gcloud compute networks create $VPC_NAME --subnet-mode=custom
    
    echo "Creating subnet '$SUBNET_NAME' in region '$REGION'..."
    gcloud compute networks subnets create $SUBNET_NAME \
        --network=$VPC_NAME \
        --range=$SUBNET_RANGE \
        --region=$REGION
    
    echo "Creating VPC-native cluster '$CLUSTER_NAME'..."
    gcloud container clusters create $CLUSTER_NAME \
        --zone $ZONE \
        --num-nodes=1 \
        --disk-type=pd-standard \
        --disk-size=12 \
        --enable-ip-alias \
        --network=$VPC_NAME \
        --subnetwork=$SUBNET_NAME \
        --cluster-ipv4-cidr=$CLUSTER_IPV4_CIDR \
        --services-ipv4-cidr=$SERVICES_IPV4_CIDR
    
    echo "Resources created successfully!"
}

function describe_resources() {
    echo "Describing VPC network..."
    gcloud compute networks describe $VPC_NAME
    
    echo -e "\nDescribing subnet..."
    gcloud compute networks subnets describe $SUBNET_NAME --region $REGION
    
    echo -e "\nDescribing cluster..."
    gcloud container clusters describe $CLUSTER_NAME --zone $ZONE
    
    echo -e "\nChecking secondary IP ranges..."
    gcloud compute networks subnets describe $SUBNET_NAME --region $REGION \
        --format="value(secondaryIpRanges)"
}

function delete_resources() {
    echo "Deleting cluster '$CLUSTER_NAME'..."
    gcloud container clusters delete $CLUSTER_NAME --zone $ZONE -q
    
    echo "Checking secondary IP ranges after cluster deletion..."
    gcloud compute networks subnets describe $SUBNET_NAME --region $REGION \
        --format="value(secondaryIpRanges)"
    
    echo "Deleting subnet '$SUBNET_NAME'..."
    gcloud compute networks subnets delete $SUBNET_NAME --region $REGION -q
    
    echo "Deleting VPC network '$VPC_NAME'..."
    gcloud compute networks delete $VPC_NAME -q
}

case "$1" in
    create)
        create_resources
        ;;
    describe)
        describe_resources
        ;;
    delete)
        delete_resources
        ;;
    *)
        echo "Usage: $0 [create|describe|delete]"
        exit 1
        ;;
esac