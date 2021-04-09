# Networking

## Network Plugin

### Network Policy
* Good examples and description in [ahmetb repo](https://github.com/ahmetb/kubernetes-network-policy-recipes)

## Ingress
Deploy ingress-nginx from manifests.
1. Download bundle file from [Github repository]() or apply what in this repository.
2. Edit deployment: hostport/nodport/...
3. Apply manfies
```
kubectl apply -f dep-ingress-nginx-hostnetwrok.yaml
```

Deploy ingress-nginx with helm
1. You can find at [artifacthub.io](https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx)
2. Add repo and pull ingress-nginx chart

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm pull ingress-nginx/ingress-nginx
```

4. Edit values
5. Install ingress-nginx charts
```
helm install ingress-nginx ./ingress-nginx
```

