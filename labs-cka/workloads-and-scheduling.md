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
