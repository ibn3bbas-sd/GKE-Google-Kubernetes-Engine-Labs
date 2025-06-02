#!/bin/bash
# Script to create and manage private GKE clusters with limited public endpoint access
# Usage: ./create-gke-clusters.sh [create|describe|update|delete]

set -e

# Configuration
ZONE="us-west1-a"
PRIVATE_CLUSTER_NAME="gke-deep-dive"
PUBLIC_CLUSTER_NAME="gke-deep-dive-public"
SUBNET_NAME="gke-deep-dive-subnet"
MASTER_CIDR_PRIVATE="172.16.0.32/28"
MASTER_CIDR_PUBLIC="172.16.0.16/28"

function create_clusters() {
    echo "Setting compute zone to $ZONE..."
    gcloud config set compute/zone $ZONE
    
    echo "Creating private cluster '$PRIVATE_CLUSTER_NAME'..."
    gcloud container clusters create $PRIVATE_CLUSTER_NAME \
        --num-nodes=1 \
        --disk-type=pd-standard \
        --disk-size=12 \
        --create-subnetwork name=$SUBNET_NAME \
        --enable-ip-alias \
        --enable-private-nodes \
        --enable-private-endpoint \
        --master-ipv4-cidr $MASTER_CIDR_PRIVATE
    
    echo "Creating public cluster '$PUBLIC_CLUSTER_NAME' with limited access..."
    gcloud container clusters create $PUBLIC_CLUSTER_NAME \
        --num-nodes=1 \
        --disk-type=pd-standard \
        --disk-size=12 \
        --enable-master-authorized-networks \
        --subnetwork $SUBNET_NAME \
        --enable-private-nodes \
        --enable-ip-alias \
        --master-ipv4-cidr $MASTER_CIDR_PUBLIC
    
    echo "Clusters created successfully!"
}

function describe_clusters() {
    echo "Describing private cluster..."
    gcloud container clusters describe $PRIVATE_CLUSTER_NAME --zone $ZONE
    
    echo -e "\nDescribing public cluster..."
    gcloud container clusters describe $PUBLIC_CLUSTER_NAME --zone $ZONE \
        --format "flattened(masterAuthorizedNetworksConfig.cidrBlocks[])"
}

function update_cluster_access() {
    echo "Getting current public IP address..."
    PUBLIC_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
    
    echo "Updating public cluster with authorized network: $PUBLIC_IP"
    gcloud container clusters update $PUBLIC_CLUSTER_NAME \
        --zone $ZONE \
        --enable-master-authorized-networks \
        --master-authorized-networks $PUBLIC_IP # $PUBLIC_IP/32
    
    echo "Enabling master global access if needed..."
    gcloud container clusters update $PUBLIC_CLUSTER_NAME \
        --enable-master-global-access
}

function delete_clusters() {
    echo "Deleting clusters..."
    gcloud container clusters delete -q $PUBLIC_CLUSTER_NAME $PRIVATE_CLUSTER_NAME --zone $ZONE
}

case "$1" in
    create)
        create_clusters
        ;;
    describe)
        describe_clusters
        ;;
    update)
        update_cluster_access
        ;;
    delete)
        delete_clusters
        ;;
    *)
        echo "Usage: $0 [create|describe|update|delete]"
        exit 1
        ;;
esac