# Cluster Architecture, Installation & Configuration

## Manage role based access control (RBAC)
## Prepare underlying infrastructure for installing a Kubernetes cluster
## Create and manage Kubernetes clusters using kubeadm
Cluster Bootstrap
```
# On control plane node:
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Set up kubeconfig
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install CNI (e.g., Calico)
k apply -f https://docs.projectcalico.org/manifests/calico.yaml

# On worker nodes:
sudo kubeadm join <control-plane-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>

# If you lost the join command
kubeadm token create --print-join-command
```

Cluster Upgrade
```bash
# Control-plane node
# 1. Update kubeadm
sudo apt-mark unhold kubeadm
sudo apt-get update && sudo apt-get install -y kubeadm=1.35.0-1.1
sudo apt-mark hold kubeadm

# 2. Plan
sudo kubeadm upgrade plan

# 3. Apply
sudo kubeadm upgrade apply v1.35.0

# 4. Update kubelet + kubectl
sudo apt-mark unhold kubelet kubectl
sudo apt-get install -y kubelet=1.35.0-1.1 kubectl=1.35.0-1.1
sudo apt-mark hold kubelet kubectl

# 5. Restart kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```

```bash
# worker node
# 1. From control plane: drain the worker
k drain worker-1 --ignore-daemonsets --delete-emptydir-data

# 2. SSH to worker, update packages
sudo apt-mark unhold kubeadm kubelet kubectl
sudo apt-get update
sudo apt-get install -y kubeadm=1.35.0-1.1 kubelet=1.35.0-1.1 kubectl=1.35.0-1.1
sudo apt-mark hold kubeadm kubelet kubectl

# 3. Upgrade node
sudo kubeadm upgrade node

# 4. Restart kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# 5. From control plane: uncordon
k uncordon worker-1
```

Cluster Reset & Recovery
```bash
kubeadm reset
```

```bash
# backup etcd
apt install etcd-client

ETCDCTL_API=3 etcdctl snapshot save /tmp/etcd-backup.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key
```

```bash
# verify
ETCDCTL_API=3 etcdctl snapshot status /tmp/etcd-backup.db --write-out="table"
```

```bash
# restore
# 1. Restore to a new directory
ETCDCTL_API=3 etcdctl snapshot restore /tmp/etcd-backup.db \
  --data-dir=/var/lib/etcd-restored

# 2. Update etcd manifest to use the restored directory
sudo vi /etc/kubernetes/manifests/etcd.yaml
# Change --data-dir=/var/lib/etcd → --data-dir=/var/lib/etcd-restored
# Change hostPath path: /var/lib/etcd → /var/lib/etcd-restored

# 3. Wait for etcd to restart (it's a static pod)
# kubectl may be unresponsive for 30-60 seconds — that's normal
```


## Manage the lifecycle of Kubernetes clusters
Node Management
```
```

## Implement and configure a highly-available control plane
## Use Helm and Kustomize to install cluster components
## Understand extension interfaces (CNI, CSI, CRI, etc.)
## Understand CRDs, install and configure operators

