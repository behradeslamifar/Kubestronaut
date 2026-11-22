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

# Workloads & Scheduling

## Understand application deployments and how to perform rolling update and rollbacks
Cheetsheat
```bash
k create deployment nginx-deployment --image nginx:latest --dry-run=client -o yaml > nginx.yaml
k delete deployment nginx-deployment [--cascade=orphan]
k set image deplyment nginx-deployment nginx=nginx:1.161
k set resources deployment/nginx-deployment -c=nginx --limits=cpu=200m,memory=512Mi
```

```bash
k rollout status deployment nginx-deployment
k rollout history deployment/nginx-deployment
k rollout history deployment/nginx-deployment --revision=2
k rollout undo deployment/nginx-deployment [--to-revision=2]
k rollout <history|pause|restart|resume|status|undo> ...
```

Try for `minReadySeconds` and `revisionHistoryLimit`
```bash
kubectl patch deployment/nginx-deployment -p '{"spec":{"progressDeadlineSeconds":600}}'
```

## Use ConfigMaps and Secrets to configure applications

Configmap cheatsheet
```bash
k create configmap app-properties --from-literal=DB_HOST=db.exampl.local
k create configmap app-properties --from-file=/path/to/app.properties
k create configmap app-properties --from-file=app-config=/path/to/app.properties
k create configmap app-properties --from-file=/path/to/folder/
k create configmap app-properties --from-env-file=env.local
```
```yaml
...
    volumeMounts:
      - name: config
        mountPath: "/config"
        readOnly: true
...
  volumes:
  # You set volumes at the Pod level, then mount them into containers inside that Pod
  - name: config
    configMap:
      # Provide the name of the ConfigMap you want to mount.
      name: game-demo
      # An array of keys from the ConfigMap to create as files
      items:
      - key: "game.properties"
        path: "game.properties"
      - key: "user-interface.properties"
        path: "user-interface.properties"
```
```yaml
...
spec:
  containers:
    - name: app
      command: ["/bin/sh", "-c", "printenv"]
      image: busybox:latest
      envFrom:
        - configMapRef:
            name: myconfigmap
```
```yaml
...
    env:
    - name: CONFIGMAP_USERNAME
      valueFrom:
        configMapKeyRef:
          name: myconfigmap
          key: username
```

Secret cheatsheet
```bash
k create secret <generic|tls|docker-registry>
k create secret generic empty-secret
k create secret generic credential --from-literal=...
k create secret generic credential --from-file=user.txt --from-file=pass.txt
```

```yaml
...
      volumeMounts:
        - name: secret-volume
          readOnly: true
          mountPath: "/etc/secret-volume"
...
  volumes:
    - name: secret-volume
      secret:
        secretName: dotfile-secret
```

```yaml
      envFrom:
      - configMapRef:
          name: app-config
      - secretRef:
          name: db-creds
```

## Configure workload autoscaling
```bash
# Manual scaling
k scale deployment nginx-test --replicas=5

# Autoscaling (HPA — not heavily tested on CKA but know it exists)
k autoscale deployment nginx-test --min=2 --max=10 --cpu-percent=80
```

## Configure Pod admission and scheduling (limits, node affinity, etc.)
### Taint and Toleration
```bash
# Taint a node (effect: NoSchedule, NoExecute, PreferNoSchedule)
kubectl taint nodes node1 key1=value1:NoSchedule

# Remove taint
kubectl taint nodes node1 key1=value1:NoSchedule-
```

Equal
```yaml
tolerations:
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoSchedule"
```

Exists
```yaml
tolerations:
- key: "key1"
  operator: "Exists"
  effect: "NoSchedule"
```

### Affinity and Anti-affinity
Node affinity
```yaml
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: topology.kubernetes.io/zone
            operator: In
            values:
            - antarctica-east1
            - antarctica-west1
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: another-node-label-key
            operator: In
            values:
            - another-node-label-value
```
