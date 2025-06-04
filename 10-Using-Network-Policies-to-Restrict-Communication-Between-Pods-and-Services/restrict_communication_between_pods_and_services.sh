#!/bin/bash

# Set default compute zone
gcloud config set compute/zone us-west1-a

# Create GKE cluster with network policy enabled
gcloud container clusters create gke-deep-dive \
  --num-nodes=1 \
  --disk-type=pd-standard \
  --disk-size=12 \
  --enable-network-policy

# Deploy Hello World application
kubectl run web-hello-world \
  --labels app=web-hello-world \
  --image=gcr.io/google-samples/hello-app:2.0 \
  --port=8080 \
  --expose

# Wait for the service to be created
kubectl get svc

# Deploy temporary frontend and backend pods
kubectl run frontend-pod \
  --labels app=frontend \
  --image=redhat/ubi8 \
  --restart=Never \
  --rm --stdin=true --tty=true

kubectl run backend-pod \
  --labels app=backend \
  --image=redhat/ubi8 \
  --restart=Never \
  --rm --stdin=true --tty=true

# Cleanup
gcloud container clusters delete gke-deep-dive
