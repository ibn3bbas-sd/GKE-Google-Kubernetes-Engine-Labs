#!/bin/bash

# Set the compute zone
gcloud config set compute/zone us-west1-a

# Create a GKE cluster
gcloud container clusters create gke-deep-dive \
  --num-nodes=1 \
  --disk-type=pd-standard \
  --disk-size=12

# Deploy the application
kubectl apply -f gke-deep-dive-app.yaml

# Show running pods
kubectl get pods

# Perform rolling updates
kubectl set image deployment nginx-deployment nginx=nginx:1.9.1
kubectl get pods
kubectl rollout status deployment/nginx-deployment

# Roll forward and backward through versions
kubectl set image deployment nginx-deployment nginx=nginx:1.7.9
kubectl rollout status deployment nginx-deployment

kubectl rollout undo deployments nginx-deployment
kubectl rollout status deployment nginx-deployment

kubectl describe deployment nginx-deployment

kubectl set image deployment nginx-deployment nginx=nginx:1.21
kubectl rollout undo deployments nginx-deployment
kubectl rollout status deployment nginx-deployment

kubectl describe deployment nginx-deployment

# Roll back to a specific revision
kubectl rollout undo deployments nginx-deployment --to-revision=1

# Clean up resources
gcloud container clusters delete gke-deep-dive --quiet --zone us-west1-a
