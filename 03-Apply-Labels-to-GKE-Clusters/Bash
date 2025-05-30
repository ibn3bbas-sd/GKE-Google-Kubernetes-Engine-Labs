#!/bin/bash

CLUSTER_NAME="gke-deep-dive"
ZONE="us-west1-a"

# Create cluster with label
gcloud container clusters create $CLUSTER_NAME --zone $ZONE --num-nodes=1 \
--disk-type=pd-standard --disk-size=10 --labels=test=gke

# Describe cluster
gcloud container clusters describe $CLUSTER_NAME --zone $ZONE

# Update cluster labels
gcloud container clusters update $CLUSTER_NAME --zone $ZONE \
--update-labels=test=gke,newlabel=gkenew

# Remove a label
gcloud container clusters update $CLUSTER_NAME --zone $ZONE \
--remove-labels=newlabel

# Final check
gcloud container clusters describe $CLUSTER_NAME --zone $ZONE