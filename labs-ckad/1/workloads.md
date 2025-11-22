# Choose and use the right workload resource

To apply any manifests run kubectl apply 
```bash
kubectl apply -f /path/to/manifest.yaml
```

## Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - image: nginx:1.14.2
    name: nginx
    ports:
    - containerPort: 80
```

### Pod exam trick
Run test cluster with kind
```bash
$ kind create cluster 
Creating cluster "kind" ...
 ✓ Ensuring node image (kindest/node:v1.27.3) 🖼
 ✓ Preparing nodes 📦  
 ✓ Writing configuration 📜 
 ✓ Starting control-plane 🕹️ 
 ✓ Installing CNI 🔌 
 ✓ Installing StorageClass 💾 
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind
```

create pod template with kubectl
```bash
kubectl run nginx-pod \
  --image=nginx \
  --port 80 \
  --dry-run=client -o yaml > pod.yaml
```


## Replicaset
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  labels:
    app: nginx
  name: nginx-replicaset
  namespace: default
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        ports:
        - containerPort: 80
      restartPolicy: Always
```

## Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx-deployment
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-deployment
  template:
    metadata:
      labels:
        app: nginx-deployment
    spec:
      containers:
      - image: nginx
        name: nginx
        ports:
        - containerPort: 80
```

Exam trick
```bash
kubectl create deployment nginx --image nginx --port 80 --dry-run=client -o yaml > deployment.yaml
```

## Daemonset
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd-elasticsearch
  namespace: kube-system
  labels:
    k8s-app: fluentd-logging
spec:
  selector:
    matchLabels:
      name: fluentd-elasticsearch
  template:
    metadata:
      labels:
        name: fluentd-elasticsearch
    spec:
      tolerations:
      # these tolerations are to have the daemonset runnable on control plane nodes
      # remove them if your control plane nodes should not run pods
      - key: node-role.kubernetes.io/control-plane
       operator: Exists
        effect: NoSchedule
      - key: node-role.kubernetes.io/master
        operator: Exists
        effect: NoSchedule
      containers:
      - name: fluentd-elasticsearch
        image: quay.io/fluentd_elasticsearch/fluentd:v2.5.2
        resources:
          limits:
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 200Mi
        volumeMounts:
        - name: varlog
          mountPath: /var/log
      # it may be desirable to set a high priority class to ensure that a DaemonSet Pod
      # preempts running Pods
      # priorityClassName: important
      terminationGracePeriodSeconds: 30
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
```

## Statefulset

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-statefulset
  labels:
    app: nginx-statefulset
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: nginx-statefulset
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  selector:
    matchLabels:
      app: nginx-statefulset
  serviceName: "nginx-statefulset"
  replicas: 3 # by default is 1
  minReadySeconds: 10 # by default is 0
  template:
    metadata:
      labels:
        app: nginx-statefulset
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: nginx
        image: registry.k8s.io/nginx-slim:0.24
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: [ "ReadWriteOnce" ]
      # storageClassName: "hostpath" # using default storage-class
      resources:
        requests:
          storage: 1Gi
```

## Job

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pi
spec:
  template:
    spec:
      containers:
      - image: perl:5.34.0
        name: pi
        caommand: ["perl", "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
  backoffLimit: 4
```

Exam trick
```bash
kubectl create job pi --image nginx --dry-run=client -o yaml > job.yaml
```

## Cronjob

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: busybox-cronjob
spec:
  schedule: '* * * * *'
  jobTemplate:
    metadata:
      creationTimestamp: null
      name: busybox-cronjob
    spec:
      template:
        spec:
          containers:
          - image: busybox:1.28
            name: busybox-cronjob
            command: 
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
```

Exam trick:
```bash
kubectl create cronjob busybox-cronjob --image busybox:1.28 --schedule "* * * * *" --dry-run=client -o yaml > cronjob.yaml
```
