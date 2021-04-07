# Kubernetes Monitoring
Kubernetes monitoring need these tools:
* metric-server: API server use this tools in autoscaling and top pods and top nodes
* kube-state-metrics: 
* cAdvisor: Integrate in kubelet and accessable with /metrics/cadvisor. cAdvisor export container metrics like, CPU, Memory, Network and ...
* node-exporter: Export node metrics


# metric-server
Documentation and manifest can be found in Github  
```
https://github.com/kubernetes-sigs/metrics-server
```

# kube-state-metrics 
Documentation can be found in Github
```
https://github.com/kubernetes/kube-state-metrics
```

### Configure kube-state-metrics with command line arguments
Configure with `args` option in Kubernetes manifests:
```
spec:
  template:
    spec:
      containers:
        - image: quay.io/coreos/kube-state-metrics:v1.9.7
          args:
          - '--telemetry-port=8081'
          - '--metric-blacklist=kube_configmap_.*'
```

# node-exporter
Install node-exporter as a systemd service  
```
apt-get install prometheus-node-exporter
```

Install node-exporter as a daemonsets
```
kubectl -n monitoring apply -f  manifests/node-exporter-daemonset.yaml
```

# Enable prometheus metrics for coredns
Configmap  
```
$ kubectl -n kube-system get configmap coredns -o yaml
...
  Corefile: |
    .:53 {
        errors
        health {
           lameduck 5s
        }
        ready
        kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           fallthrough in-addr.arpa ip6.arpa
           ttl 30
        }
        prometheus :9153
...
```

Service
```
$ kubectl -n kube-system get service kube-dns -o yaml
...
  - name: metrics
    port: 9153
    protocol: TCP
    targetPort: 9153
...
```

# Blackbox Exporter
** This isnt part of CKA exam **
You can find project at [github repo](https://github.com/prometheus/blackbox_exporter)  

Install with helmi([artifacthub](https://artifacthub.io/packages/helm/prometheus-community/prometheus-blackbox-exporter))
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install [RELEASE_NAME] prometheus-community/prometheus-blackbox-exporter
```

# Deploy Prometheus 
** This isnt part of CKA exam **
Prometheus have two deployment method
* Prometheus Deployment
* prometheus-oprator

### Prometheus Deployment
Prometheus manifests include
* Serviceaccount
* ClusterRole and ClusterRoleBinding to access metrics api
* Configmap: Prometheus config
* Deployment: Deployment Prometheus service

```
cd manifests
kubectl apply -f prometheus-deployment.yaml
```

### prometheus-operator
** This isnt part of CKA exam **

```
wget https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml
kubectl apply -f bundle.yaml
```
