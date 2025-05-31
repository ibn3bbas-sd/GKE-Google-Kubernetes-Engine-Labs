# GKE Private Cluster with Limited Public Access

This repository contains scripts and documentation for creating Google Kubernetes Engine (GKE) clusters with private nodes and controlled access to the control plane.

## Features

- Creates a fully private GKE cluster with no public endpoint access
- Creates a second cluster with private nodes but limited public endpoint access
- Automates IP authorization for secure access
- Provides cleanup functionality

## Prerequisites

1. Google Cloud SDK installed and configured
2. Kubernetes (`kubectl`) installed
3. Appropriate GCP project permissions
4. DNS utilities (`dig`) for IP detection

## Usage

### 1. Create clusters
```bash
chmod +x create-gke-clusters.sh
./create-gke-clusters.sh create