# 🚀 Kubernetes (kind) Setup on Windows 11

This repository provides a **one-click PowerShell script** to install and configure a local Kubernetes cluster using **kind (Kubernetes IN Docker)** on Windows 11.

---

## 📌 Prerequisites

Before running the setup script, ensure:

* ✅ Windows 11
* ✅ Docker Desktop installed and running
* ✅ Virtualization enabled in BIOS
* ✅ PowerShell running as Administrator

---

## ⚙️ What This Setup Does

The script automates the following:

* Installs **Chocolatey** (if not installed)
* Installs:

  * `kind`
  * `kubectl`
* Creates a Kubernetes cluster configuration file
* Deploys a **multi-node cluster**:

  * 1 Control Plane
  * 3 Worker Nodes
* Verifies cluster status

---

## 📂 Project Structure

```
.
├── setup-kind.ps1        # One-click setup script
├── kind-cluster.yaml     # Cluster configuration (auto-generated)
└── README.md             # Documentation
```

---

## ▶️ How to Run

1. Clone the repository:

```bash
git https://github.com/Shubham382/kind_k8s_Setup_on_Windows11.git
cd kind_k8s_Setup_on_Windows11
```

2. Open **PowerShell as Administrator**

3. Run the script:

```powershell
.\setup-kind.ps1
```

---

## 🧪 Verify Installation

After execution, verify cluster:

```bash
kubectl get nodes
kubectl cluster-info
```

Expected output:

* All nodes should be in `Ready` state
* Kubernetes control plane should be accessible

---

## ⚠️ Known Behavior

### Cluster Already Exists Error

If you see:

```
ERROR: failed to create cluster: node(s) already exist
```

👉 This means the cluster is already running (not a failure).

### Solution Options:

#### ✅ Option 1: Skip Creation (Recommended)

Script can be updated to check existing clusters before creating.

#### 🔄 Option 2: Recreate Cluster

```bash
kind delete cluster --name kind-cluster
kind create cluster --config kind-cluster.yaml --name kind-cluster
```

---

## 🧠 DevOps Best Practice

This setup follows:

* ✅ Idempotent scripting approach
* ✅ Automated environment provisioning
* ✅ Infrastructure as Code (IaC) mindset

---

## 📦 Cluster Configuration

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1
```

---

## 🚀 Next Steps

After cluster setup, you can:

* Deploy applications using `kubectl`
* Use Helm for package management
* Setup Ingress Controller (NGINX)
* Deploy microservices architecture
* Migrate Docker Compose apps to Kubernetes

---

## 🛠️ Useful Commands

```bash
# List clusters
kind get clusters

# Delete cluster
kind delete cluster --name kind-cluster

# Get nodes
kubectl get nodes

# Get pods
kubectl get pods -A
```

---

## 🤝 Contributing

Feel free to fork and improve this setup. Suggestions and improvements are welcome!

---

## 📄 License

This project is open-source and available under the MIT License.

---

## 👨‍💻 Author

DevOps Engineer | Shubham Mandavkar
