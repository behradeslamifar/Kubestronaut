# CKAD Cheat Sheet - Review before exam

**Jump to:** [Application Design and Build](#Application-Design-and-Build) | [](#) | [](#) | [](#) | [Network Policies](#Network-Policies) |

## Application Design and Build
```bash
docker container commit -m "add new layer" container_name new_image_name
docker container commit -C "new command" -m "new layer" container_name new_image_name
docker image history new_image_name

docker build -f /path/to/Dockerfile -t ubunut:newtag .
docker build --pull --no-cache -t image:newtag .
docker images

# Common command in  Docker file
FROM ubuntu:latest
 
# Set multiple labels at once, using line-continuation characters to break long lines
LABEL vendor=ACME\ Incorporated \
      com.example.is-beta= \
      com.example.is-production="" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2015-02-12"
 
RUN apt update && apt install -y python3

WORKDIR /app
COPY app.py ./

RUN useradd app
USER app

CMD ["/usr/bin/python3", "app.py"]
```

```bash
kubectl create cronjob backup-runner \
  --image=busybox \
  --schedule="30 2 * * *" \
  -- /bin/sh -c "echo 'Running backup'; backup.sh"

k create job test-job --from=cronjob/backup-runner
```

```
# Deployment
k create deployment nginx-deployment --image nginx:latest --dry-run=client -o yaml > nginx.yaml
k delete deployment nginx-deployment [--cascade=orphan]
k set image deplyment nginx-deployment nginx=nginx:1.161
k set resources deployment/nginx-deployment -c=nginx --limits=cpu=200m,memory=512Mi
k set resources -f /tmp/nginx.yaml --limits cpu=1,memory=100Mi --local -o yaml
 
k rollout status deployment nginx-deployment
k rollout history deployment/nginx-deployment
k rollout history deployment/nginx-deployment --revision=2
k rollout undo deployment/nginx-deployment [--to-revision=2]
k rollout <history|pause|restart|resume|status|undo> ...
 
# Try for `minReadySeconds` and `revisionHistoryLimit`
kubectl patch deployment/nginx-deployment -p '{"spec":{"progressDeadlineSeconds":600}}'
```

```
# Job
k create job backup --image ubuntu -- backup.sh

# Options
apiVersion: batch/v1
kind: Job
metadata:
  name: pi
spec:
  template:
    spec:
      containers:
      - name: pi
        image: perl:5.34.0
        command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
  activeDeadlineSeconds: 120 # Job should terminate after 120 seconds
  concurrentPolicy: Forbid # Prevent new job trigger before previous one finish (Allow, Forbid, Replace)
  completions: 10
  parallelism: 3
  completionMode: Indexed  # required for the feature
  backoffLimitPerIndex: 1  # maximal number of failures per index
  maxFailedIndexes: 5      # maximal number of failed indexes before terminating the Job execution
  backoffLimit: 4          # if non-indexed
```

```
# Cronjob
k create cronjob backup --image=busybox --schadule="30 0 * * *" -- backup.sh

# View running jobs
kubectl get job -l cronjob=backup-runner

# View job history
kubectl get job -l cronjob=backup-runner --sort-by='.metadata.creationTimestamp'

# Manually trigger (test before schedule time)
k create job backup-manual-test --from=cronjob/backup

# Options
spec:
  # Keep only 3 successful runs in history
  successfulJobsHistoryLimit: 3
  
  # Keep only 1 failed run in history
  failedJobsHistoryLimit: 1
```

```
# Multi-container - InitContainers
initContainers:
- name: logger
  image: busybox
  restartPolicy: Always # With Always initcontainer convert to Native sidecar
  command: ["sh", "-c", "sleep 3600"]
```

```
# Utilize persistent and ephemeral volumes
spec:
  containers:
  - image: registry.k8s.io/test-webserver
    name: test-container
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir:
      mode: 01777
```

## Application Deployment

```
# Use Kubernetes primitives to implement common deployment strategies (e.g. blue/green or canary)
metadata:
  name: rollout-demo-stable
  labels:
    app.kubernetes.io/name: rollout-demo
    track: stable

metadata:
  name: rollout-demo-stable
  labels:
    app.kubernetes.io/name: rollout-demo
    track: cannary

apiVersion: v1
kind: Service
...
spec:
  type: ClusterIP
  selector:
    app.kubernetes.io/name: rollout-demo


# Mirgrating to new version
kubectl set image deployment/rollout-demo-stable rollout-demo=gcr.io/google-samples/hello-app:2.0
kubectl set env deployment/rollout-demo-stable VERSION=v2

k rollout status deployment nginx-deployment
k rollout history deployment/nginx-deployment
k rollout history deployment/nginx-deployment --revision=2
k rollout undo deployment/nginx-deployment [--to-revision=2]
k rollout <history|pause|restart|resume|status|undo> ...
```

```
# helm
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update

helm install <release> <chart> -n <ns>
helm install <release> <chart> -n <ns> -f <values.yaml>
helm upgrade <release> <chart> -n <ns> --set key=value
helm rollback <release> <revision> -n <ns>

helm upgrade --install metrics-server metrics-server/metrics-server

# Verify
helm list -n <ns>
helm history metric-server -n kube-system

# cleanup
helm uninstall metric-server -n kube-system
```

```
# Kustomize
```

## Application Observability and Maintenance

```
# Probes and Health checks
spec:
  containers:
  - name: liveness
    livenessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5

# HTTP Request probe
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
        httpHeaders:
        - name: Custom-Header
          value: Awesome

# HTTP2 
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
        protocol: HTTP2

# liveness and readiness probes with TCP
    readinessProbe:
      tcpSocket:
        port: 8080
    livenessProbe:
      tcpSocket:
        port: 8080

# startupProbe
    startupProbe:
      httpGet:
        path: /healthz
        port: 8080

# Options
initialDelaySeconds: 10 #probe will start after 10 seconds, default 0
periodSeconds: 5  #probe endpoint every 5 seconds, default 10
timeoutSeconds: 3 #3 seconds wait for probe result, default 1
failureThreshold: 3 #After 3 time probe failure, consider pod failes, default 3
successThreshold: 3 #After 3 times probe success consider pod live and running, default 1
terminationGracePeriodSeconds: 30 #30 seconds to force pod to shutdown
```

## Application Environment, Configuration and Security

```
# RBAC
k create role <name> --verb=get,list,watch --resource=pods -n <ns>
k create rolebinding <name> --role=<role> --serviceaccount=<ns>:<sa> -n <ns>
k create clusterrole <name> --verb=get,list --resource=nodes
k create clusterrolebinding <name> --clusterrole=<cr> --serviceaccount=<ns>:<sa>
k auth can-i <verb> <resource> -n <ns> --as=system:serviceaccount:<ns>:<sa>
```

```
# Quota
apiVersion: v1
kind: ResourceQuota
metadata:
  name: production-quota
  namespace: production

spec:
  hard:
    # CPU resources
    requests.cpu: "10"
    limits.cpu: "20"

    # Memory resources
    requests.memory: "20Gi"
    limits.memory: "40Gi"

    # Ephemeral storage
    requests.ephemeral-storage: "50Gi"
    limits.ephemeral-storage: "100Gi"

    # GPU resources (requires GPU support)
    requests.nvidia.com/gpu: "4"

    # Pod count
    pods: "30"

    # Storage
    requests.storage: "500Gi"
    persistentvolumeclaims: "20"

    # Services
    services: "20"
    services.loadbalancers: "2"
    services.nodeports: "5"

    # ConfigMaps and Secrets
    configmaps: "50"
    secrets: "100"

    # Workload objects
    count/deployments.apps: "10"
    count/statefulsets.apps: "5"
    count/daemonsets.apps: "3"
    count/jobs.batch: "20"
    count/cronjobs.batch: "10"

    # Other Kubernetes API objects
    count/replicasets.apps: "30"
    count/ingresses.networking.k8s.io: "10"

# limitrange
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-resource-constraint
spec:
  limits:
  - default: # this section defines default limits
      cpu: 500m
      memory: "100Mi"
    defaultRequest: # this section defines default requests
      cpu: 500m
    max: # max and min define the limit range
      cpu: "1"
    min:
      cpu: 100m
    maxLimitRequestRatio:
      cpu: 2
    type: Container # Pod, Container, PersistentVolumeClaim
```

```
# Configmaps
k create configmap app-properties --from-literal=DB_HOST=db.exampl.local
k create configmap app-properties --from-file=/path/to/app.properties
k create configmap app-properties --from-file=app-config=/path/to/app.properties
k create configmap app-properties --from-file=/path/to/folder/
k create configmap app-properties --from-env-file=env.local

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

...
spec:
  containers:
    - name: app
      command: ["/bin/sh", "-c", "printenv"]
      image: busybox:latest
      envFrom:
        - configMapRef:
            name: myconfigmap

...
    env:
    - name: CONFIGMAP_USERNAME
      valueFrom:
        configMapKeyRef:
          name: myconfigmap
          key: username
```

```
# Secrets
k create secret <generic|tls|docker-registry>
k create secret generic empty-secret
k create secret generic credential --from-literal=...
k create secret generic credential --from-file=user.txt --from-file=pass.txt

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

      envFrom:
      - configMapRef:
          name: app-config
      - secretRef:
          name: db-creds
```

```
# Resources

spec:
  containers:
  - name: app
    image: nginx:latest
    resources:  # Container lever resource limit
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
  resources:
    requests:
      cpu: 1
    limits:
      cpu: 2
```

```
# Service account - Bound Service Account Tokens
k create serviceaccount ckad
k exec -ti <pod-name> -- cat /var/run/secrets/kubernetes.io/serviceaccount/token

# token exire time
k exec -ti nginx2-bb69cbc8b-8f8lm -- cat /var/run/secrets/kubernetes.io/serviceaccount/token | cut -f 2 -d "." | base64 -d | jq .exp | xargs -I{} date -d @{}

spec:
  serviceAccount: ckad
  containers:
    - name: web
      image: nginx

# ServiceAccount - TokenRequest API
kubectl create serviceaccount ckad-tokenrequest
kubectl create token ckad-tokenrequest --duration 1h

# ServiceAccount - Legacy ServiceAccount Token
# Create non-expiring token
kubectl create serviceaccount ckad-legacy

apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: ckad-legacy
  annotations:
    kubernetes.io/service-account.name: ckad-legacy
```

```
# Understand Application Security (SecurityContexts, Capabilities, etc.)
spec:
  securityContext: # Pod level
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  containers:
  - name: nginx
    image: nginx
    securityContext:  # Container Level
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop: ["ALL"]

spec:
  securityContext:
    sysctls:
    - name: net.core.somaxconn
      value: "1024"
    - name: net.ipv4.ip_local_port_range
      value: "10000 65000"

spec:
  containers:
  - name: app
    image: nginx
    securityContext:
      capabilities:
        add:
        - NET_BIND_SERVICE
        - NET_RAW
```

## Services and Networking

```
## Network Policies

```
