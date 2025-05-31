#!/bin/bash

# Step 1: Install Kubectl
echo "Installing kubectl..."
sudo apt-get update
sudo apt-get install -y kubectl

# Verify installation
echo "Verifying kubectl installation..."
kubectl version --client

# Step 2: Verify installation of required plugins
echo "Checking for gke-gcloud-auth-plugin..."
if ! gke-gcloud-auth-plugin --version &>/dev/null; then
    echo "Installing gke-gcloud-auth-plugin..."
    gcloud components install gke-gcloud-auth-plugin
fi

# Step 3: Generate kubeconfig context
echo "Generating kubeconfig context..."
gcloud container clusters get-credentials CLUSTER_NAME --region=COMPUTE_REGION

# Step 4: Verify the configuration
echo "Verifying configuration..."
kubectl get namespaces

# Step 5: View Kubeconfig
echo "Viewing kubeconfig..."
kubectl config view

# Step 6: Install a test app
echo "Installing test app..."
kubectl run my-app --image gcr.io/cloud-marketplace/google/nginx1:latest

# Step 7: Verify the app by listing pods
echo "Listing pods..."
kubectl get pods