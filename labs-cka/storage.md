# Storage

## Implement storage classes and dynamic volume provisioning

## Configure volume types, access modes and reclaim policies

## Manage persistent volumes and persistent volume claims

### commands, utilities and shortcuts
options: --from-env-file, --from-file, --from-literal 
```
kubectl create configmaps my-config --from-file=/path/to/file.txt
```

Create deployment
```
kubectl create deployments my-deployment --image nginx --dry-drun -o yaml
```

add `my-config` to deployment, configure `volumes` and `volumeMounts`
