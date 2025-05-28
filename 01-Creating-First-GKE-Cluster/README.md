---

# 🚀 GKE Deep Dive: Creating Our First GKE Cluster


Welcome! This repo provides a step-by-step guide and shell scripts for creating, verifying, and deleting your first Google Kubernetes Engine (GKE) cluster.

---

## 📦 Project Structure

* **scripts/** → Shell scripts to automate cluster setup
* **docs/** → PDF lab guide for reference
* **.github/** → GitHub metadata (issues, PR templates)
* **README.md** → This guide

---

## 🛠 Prerequisites

✅ Google Cloud account
✅ `gcloud` CLI installed or use Google Cloud Shell
✅ Permissions to create GKE clusters

---

## ⚙️ Commands & Scripts

### 1️⃣ Set Default Zone

```bash
gcloud config set compute/zone us-west1-a
```

### 2️⃣ Create Cluster

```bash
./scripts/create_cluster.sh
```

### 3️⃣ Verify Cluster

```bash
./scripts/verify_cluster.sh
```

### 4️⃣ Delete Cluster

```bash
./scripts/delete_cluster.sh
```

---

## 🖥 Scripts Details

* **create\_cluster.sh**

  ```bash
  gcloud container clusters create gke-deep-dive --num-nodes=1 --disk-type=pd-standard --disk-size=10
  ```

* **verify\_cluster.sh**

  ```bash
  gcloud container clusters list
  ```

* **delete\_cluster.sh**

  ```bash
  gcloud container clusters delete gke-deep-dive --quiet
  ```

---

Nice — I’ll update the README to **also include the multi-zonal cluster section**!

Here’s the new part you can add under the ⚙️ **Commands & Scripts** section.

---

### 🌍 Multi-Zonal Cluster Setup

To create a **multi-zonal** cluster, use the `--node-locations` flag.

```bash
gcloud container clusters create gke-deep-dive \
  --num-nodes=3 \
  --disk-type=pd-standard \
  --disk-size=10 \
  --zone us-central1-a \
  --node-locations us-west1-a,us-west1-b,us-west1-c
```

✅ **What this does:**

* Creates a GKE cluster named `gke-deep-dive`
* Uses 3 nodes
* Distributes across `us-west1-a`, `us-west1-b`, `us-west1-c`

🔗 [GCloud create cluster reference](https://cloud.google.com/sdk/gcloud/reference/container/clusters/create#--node-locations)

---

### 📂 Suggested Scripts Folder Update

You can also add a script in `scripts/create_multi_zone_cluster.sh` with:

```bash
#!/bin/bash
gcloud container clusters create gke-deep-dive \
  --num-nodes=3 \
  --disk-type=pd-standard \
  --disk-size=10 \
  --zone us-central1-a \
  --node-locations us-west1-a,us-west1-b,us-west1-c
```

---

## 📚 Resources

* [GKE Quickstart](https://cloud.google.com/kubernetes-engine/docs/quickstart)
* [gcloud Reference](https://cloud.google.com/sdk/gcloud/reference/container/clusters/create#--node-locations)

---

## 📄 License

MIT License

---

### ✨ GitHub Icons & Badges

You can add some badges at the top of the README, like:

```markdown
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![GCP](https://img.shields.io/badge/GCP-GKE-blue)
```

---

Want me to package those up? 🚀
