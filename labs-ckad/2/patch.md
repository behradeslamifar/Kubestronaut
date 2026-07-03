# kubectl patch
kubectl patch types
- json: JSON Patch, RFC 6902
- merge: JSON Merge Patch, RFC 7386
- strategic: Strategic merge patch

Deploy nginx deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
```

# json
op: "add", "remove", "replace", "move" and "copy"
type: --type json

```bash
kubectl patch deployment my-app --type='json' -p='[
  {"op":"remove","path":"/spec/template/spec/containers/1"}
]'
```

```bash
kubectl patch deployment my-app \
  --type='json' \
  -p='[
        {"op":"replace","path":"/spec/replicas","value":3}
      ]'
```

# merge
path-file.yaml
```yaml  
spec:    
  template:
    spec:
      containers:
      - name: cache  
        image: redis 
```

replace containers list with new one
```bash
kubectl patch deployment nginx-deployment --type merge --patch-file patch-file.yaml
```

# strategic (default)
default strategy is `merge` in most api for list, if api dont have patch strategy it will be `replace`.

example: Add redis container to the deployment
path-file.yaml
```yaml
spec:
  template:
    spec:
      containers:
      - name: cache
        image: redis
```

```bash
kubectl patch deployment nginx-deployment --patch-file patch-file.yaml
```

## Resources
- [Kubernetes Patch Strategies](https://github.com/nubank/k8s-api/blob/master/doc/kubernetes-patch-strategies.md)
- [Update API Object kubectl patch](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/update-api-object-kubectl-patch/)
