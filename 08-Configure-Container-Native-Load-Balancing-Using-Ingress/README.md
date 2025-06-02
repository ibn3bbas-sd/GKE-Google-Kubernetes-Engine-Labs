# Container-Native Load Balancing with GKE Ingress

This repository demonstrates how to configure container-native load balancing using Ingress in Google Kubernetes Engine (GKE).

## Features

- Creates a VPC-native GKE cluster with custom subnet
- Deploys a sample application with multiple replicas
- Configures a Kubernetes Service with Network Endpoint Groups (NEGs)
- Sets up an Ingress resource that provisions a Google Cloud HTTP(S) Load Balancer
- Includes verification steps for load balancing functionality
- Provides complete cleanup of all resources

## Prerequisites

1. Google Cloud SDK installed and configured
2. Kubernetes (`kubectl`) installed
3. Appropriate GCP project permissions
4. Enabled GKE and Compute Engine APIs

## Usage

### 1. Create resources (cluster, deployment, service, ingress)
```bash
chmod +x configure-ingress-lb.sh
./configure-ingress-lb.sh create