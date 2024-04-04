# Kind
kind is a tool for running local Kubernetes clusters using Docker container "nodes"

## Run your first Kubernetes cluster
- [Install kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- Create config file: `ckad.yaml`
```
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

- Creating a cluster
```
$ kind create cluster --name ckad --config ckad.yaml
Creating cluster "ckad" ...
 ✓ Ensuring node image (kindest/node:v1.27.3) 🖼
 ✓ Preparing nodes 📦 📦 📦  
 ✓ Writing configuration 📜 
 ✓ Starting control-plane 🕹️ 
 ✓ Installing CNI 🔌 
 ✓ Installing StorageClass 💾 
 ✓ Joining worker nodes 🚜 
Set kubectl context to "kind-ckad"
You can now use your cluster with:

kubectl cluster-info --context kind-ckad

Not sure what to do next? 😅  Check out https://kind.sigs.k8s.io/docs/user/quick-start/
```

- Test your access to new cluster with `kubectl`
```
kubectl cluster-info --context kind-ckad
```
