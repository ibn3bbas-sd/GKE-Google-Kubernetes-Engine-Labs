# GKE Deep Dive Load Balancer Setup

This repo contains scripts and configuration files to set up a **Google Kubernetes Engine (GKE)** cluster with a backend service-based external passthrough load balancer.

---

## 📦 Contents

- `backend_external_load_balancer.sh` — Automated deployment script
- `gke-deep-dive-app.yaml` — Kubernetes deployment manifest
- `gke-deep-dive-svc.yaml` — Kubernetes service manifest
- `LICENSE` — MIT License

---

## 🚀 Quick Start

1️⃣ **Prerequisites**
- Google Cloud account
- `gcloud` CLI installed
- `kubectl` installed

2️⃣ **Run the deployment script**
```bash
chmod +x backend_external_load_balancer.sh
./backend_external_load_balancer.sh