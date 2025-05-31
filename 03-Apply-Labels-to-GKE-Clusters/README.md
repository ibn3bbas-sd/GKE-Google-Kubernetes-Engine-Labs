# GKE Cluster Labeling

This project contains scripts and instructions for applying, updating, and removing labels on Google Kubernetes Engine (GKE) clusters.

## Prerequisites

- Google Cloud SDK (`gcloud`)
- Access to a GCP project with GKE API enabled
- Permissions to create and update clusters

## Steps

1. **Create a cluster with labels**

gcloud container clusters create gke-deep-dive --zone us-west1-a --num-nodes=1 --disk-type=pd-standard --disk-size=12 --labels=test=gke

2. **Describe the cluster to verify labels**  

gcloud container clusters describe gke-deep-dive --zone us-west1-a


3. **Update or add new labels**  

gcloud container clusters update gke-deep-dive --zone us-west1-a --update-labels=newlabel=gkenew


⚠️ Note: Updating labels will overwrite existing ones unless you include them all.

4. **Remove labels**  

gcloud container clusters update gke-deep-dive --zone us-west1-a --remove-labels=newlabel


---