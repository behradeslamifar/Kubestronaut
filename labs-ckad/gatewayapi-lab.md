# GatewayAPI
## GatewayAPI and cloud-provider-kind
### Install cloud-provider-kind

### Run cloud-provider-kind
To support GatewayAPI support you have to use --gateway-channel standard
```bash
cloud-provider-kind --gateway-channel standard
```

cloud-provide-kind will create Gatewayclass also
```bash
$ kubectl get gatewayclasses.gateway.networking.k8s.io 
NAME                  CONTROLLER                            ACCEPTED   AGE
cloud-provider-kind   kind.sigs.k8s.io/gateway-controller   True       154m
```
### Step 3: Create a Gateway
Apply this manifest
```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: kind-http-gateway
spec:
  gatewayClassName: istio
  listeners:
  - name: http
    protocol: HTTP
    port: 80
```

## GatewayAPI and Istio
### Step 1: Create GatewayAPI CRD's
Install GatewayAPI CRD's
```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/latest/download/standard-install.yaml
```

Verify the CRDs were installed:
```bash
kubectl get crd | grep "gateway.networking.k8s.io"
```

### Step 2: Deploy Gateway Controller
GatewayAPI dont have default controller, so you have deploy one (Istio, Kong, Envoy, cloud-provider-kind). Here we are installing Istio
```bash
istioctl install --set profile=default
```

### Step 3: Define GatewayClass
istio will create `istio` gatewayclass by default
```bash
$ kubectl get gatewayclasses.gateway.networking.k8s.io 
NAME                  CONTROLLER                            ACCEPTED   AGE
istio                 istio.io/gateway-controller           True       25m
```

If it didnt apply this manifest
```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: istio
spec:
  controllerName: istio.io/gateway-controller
```

### Step 4: Create a Gateway
Apply this manifest
```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: istio-http-gateway
spec:
  gatewayClassName: istio
  listeners:
  - name: http
    protocol: HTTP
    port: 80
```

### Final step
Now we are ready to create HTTPRoute
```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: first-service
spec:
  parentRefs:
  - name: istio-http-gateway
  rules:
  - matches:
    - path:
        type: Prefix
        value: "/api"
    backendRefs:
    - name: first-service
      port: 8080
```
