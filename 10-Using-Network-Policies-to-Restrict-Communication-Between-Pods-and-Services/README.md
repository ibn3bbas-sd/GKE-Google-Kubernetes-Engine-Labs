# Kubernetes Network Policy Exercise

This repository contains files for setting up and testing Kubernetes Network Policies using GKE and `kubectl`.

## Objectives

- Deploy a web application in Kubernetes.
- Implement Ingress and Egress network policies.
- Test pod-to-pod communication restrictions.

## Prerequisites

- Google Cloud SDK (`gcloud`)
- Kubernetes CLI (`kubectl`)
- A GCP project with billing enabled

## Setup Instructions

### 1. Configure and Deploy GKE Cluster

### Apply Network Policies

kubectl apply -f ingress.yaml
kubectl apply -f egress.yaml

```bash
bash network-setup.sh


