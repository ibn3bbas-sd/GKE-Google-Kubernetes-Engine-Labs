# GKE Cluster Autoscaling Setup

This repository contains a simple bash script to configure Google Kubernetes Engine (GKE) cluster autoscaling.

## Overview

The script does the following:
1. Creates a GKE cluster without autoscaling.
2. Adds a node pool with autoscaling enabled.
3. Verifies that autoscaling is enabled.
4. Optionally disables autoscaling.

## Prerequisites

- Google Cloud SDK (`gcloud`) installed and configured.
- Appropriate permissions to manage GKE clusters.

## Usage

```bash
bash configure-autoscaling.sh
