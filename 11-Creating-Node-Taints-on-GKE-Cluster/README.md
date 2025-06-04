# GKE Node Taints Playground

This project demonstrates how to create and manage node taints in a Google Kubernetes Engine (GKE) cluster. It walks through creating clusters, applying taints, deploying pods with tolerations, and observing scheduling behavior.

## 🛠 Prerequisites

- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- Enabled Kubernetes Engine API
- Authenticated with `gcloud auth login`
- Set your project via `gcloud config set project <PROJECT_ID>`


## 🚀 Setup Instructions

chmod +x bash/gke_taints.sh
./bash/gke_taints.sh

## 📄 Pod Manifests

shared-pod.yaml: Pod that tolerates the function=shared:NoSchedule taint.
dedicated-pod.yaml: Pod without tolerations (won’t be scheduled on tainted nodes).

## 🧪 Apply Pods

kubectl apply -f yamls/shared-pod.yaml
kubectl apply -f yamls/dedicated-pod.yaml

## ❓ Troubleshooting

    - Check node taints:
      kubectl describe nodes

    - Remove taints:
      kubectl taint nodes <node-name> function-

## 📦 Project Structure

```bash
.
├── bash
│   └── gke_taints.sh
├── yamls
│   ├── shared-pod.yaml
│   └── dedicated-pod.yaml
├── LICENSE
└── README.md