# VPC-native GKE Cluster Deployment

This repository contains scripts to create and manage a VPC-native Google Kubernetes Engine (GKE) cluster with custom networking configuration.

## Features

- Creates a custom VPC network with a dedicated subnet
- Provisions a VPC-native GKE cluster with alias IP ranges
- Automatically configures secondary IP ranges for pods and services
- Provides clean resource deletion
- Includes verification steps for all created resources

## Prerequisites

1. Google Cloud SDK installed and configured
2. Appropriate GCP project permissions
3. Kubernetes (`kubectl`) installed (optional for basic operations)
4. Enabled GKE API in your GCP project

## Usage

### 1. Create resources (VPC, subnet, and cluster)
```bash
chmod +x create-vpc-native-cluster.sh
./create-vpc-native-cluster.sh create