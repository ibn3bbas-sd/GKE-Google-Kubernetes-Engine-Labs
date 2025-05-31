# GKE Manual Upgrade Script

This repository contains a script to manually upgrade a Google Kubernetes Engine (GKE) cluster and its node pool.

## 📦 Files

- `upgrade-gke.sh` — Bash script to automate:
    - Creating a GKE cluster
    - Checking available control plane versions
    - Upgrading the control plane
    - Upgrading the node pool

- `LICENSE` — MIT open-source license.

## ⚙️ Prerequisites

- Google Cloud SDK installed and authenticated
- Permissions to create and upgrade GKE clusters
- Billing enabled on your Google Cloud project

## 🚀 Usage

1. **Make the script executable**

    ```bash
    chmod +x upgrade-gke.sh
    ```

2. **Run the script**

    ```bash
    ./upgrade-gke.sh
    ```

3. **Customize parameters**

    Edit the variables at the top of `upgrade-gke.sh` to set your desired:
    - Cluster name
    - Region/zone
    - Node pool name
    - Target Kubernetes version

## 📖 References

- [GKE Upgrades Documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/upgrading-a-cluster)
- [Google Cloud CLI Reference](https://cloud.google.com/sdk/gcloud/reference/container/clusters/upgrade)

## 🛡 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
