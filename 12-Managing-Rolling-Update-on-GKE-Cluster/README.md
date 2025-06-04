# GKE Rolling Update Exercise

This project demonstrates how to manage rolling updates in a **Google Kubernetes Engine (GKE)** cluster using `kubectl`.

## 🛠️ Prerequisites

- Google Cloud SDK
- GKE API enabled
- `kubectl` configured for your project

## 📋 Steps Overview

1. **Cluster Setup** – Create a GKE cluster.
2. **Deployment** – Deploy an NGINX-based app.
3. **Rolling Updates** – Use `kubectl set image` and `kubectl rollout` commands.
4. **Rollbacks** – Undo deployments and navigate between revisions.

## 🚀 Getting Started

To execute the full lifecycle:

```bash
chmod +x setup-gke-rolling-update.sh
./setup-gke-rolling-update.sh
