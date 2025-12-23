# Istio Lab: Install and Preparation

## Kubernetes Cluster with Kind
kind is a tool for running local Kubernetes clusters using Docker container "nodes"

### Run your first Kubernetes cluster
- [Install kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management)
- Create config file: `istio.yaml`
```
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
```

- Create a cluster
```
kind create cluster --name istio --config=istio.yaml
```

- Test your access to the cluster
```
kubectl cluster-info --context kind-istio
```

- [Install cloud-provider-kind](https://github.com/kubernetes-sigs/cloud-provider-kind?tab=readme-ov-file#install) and run it


### Quick Install Istio with istioctl
- [Install istioctl](https://istio.io/latest/docs/setup/getting-started/#download)
- Install Istio
```
istioctl install --set profile=demo
```

<details><summary>Output</summary>
<p>


```
This will install the Istio 1.19.3 "demo" profile (with components: Istio core, Istiod, Ingress gateways, and Egress gateways) into the cluster. Proceed? (y/N) y
✔ Istio core installed                                                                                                                        
✔ Istiod installed                                                                                                                            
✔ Egress gateways installed                                                                                                                   
✔ Ingress gateways installed                                                                                                                  
✔ Installation complete                                                                                                                       Made this installation the default for injection and validation.
```

</p>
</details>

- Verify installation
```
istioctl verify-install
```

<details><summary>Output</summary>
<p>


```
1 Istio control planes detected, checking --revision "default" only
✔ HorizontalPodAutoscaler: istio-ingressgateway.istio-system checked successfully
✔ Deployment: istio-ingressgateway.istio-system checked successfully
✔ PodDisruptionBudget: istio-ingressgateway.istio-system checked successfully
✔ Role: istio-ingressgateway-sds.istio-system checked successfully
✔ RoleBinding: istio-ingressgateway-sds.istio-system checked successfully
✔ Service: istio-ingressgateway.istio-system checked successfully
✔ ServiceAccount: istio-ingressgateway-service-account.istio-system checked successfully
✔ ServiceAccount: istio-reader-service-account.istio-system checked successfully
✔ CustomResourceDefinition: wasmplugins.extensions.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: destinationrules.networking.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: envoyfilters.networking.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: gateways.networking.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: proxyconfigs.networking.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: serviceentries.networking.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: sidecars.networking.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: virtualservices.networking.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: workloadentries.networking.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: workloadgroups.networking.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: authorizationpolicies.security.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: peerauthentications.security.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: requestauthentications.security.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: telemetries.telemetry.istio.io.istio-system checked successfully
✔ CustomResourceDefinition: istiooperators.install.istio.io.istio-system checked successfully
✔ HorizontalPodAutoscaler: istiod.istio-system checked successfully
✔ ClusterRole: istiod-clusterrole-istio-system.istio-system checked successfully
✔ ClusterRole: istiod-gateway-controller-istio-system.istio-system checked successfully
✔ ClusterRoleBinding: istiod-clusterrole-istio-system.istio-system checked successfully
✔ ClusterRoleBinding: istiod-gateway-controller-istio-system.istio-system checked successfully
✔ ConfigMap: istio.istio-system checked successfully
✔ Deployment: istiod.istio-system checked successfully
✔ ConfigMap: istio-sidecar-injector.istio-system checked successfully
✔ MutatingWebhookConfiguration: istio-sidecar-injector.istio-system checked successfully
✔ PodDisruptionBudget: istiod.istio-system checked successfully
✔ ClusterRole: istio-reader-clusterrole-istio-system.istio-system checked successfully
✔ ClusterRoleBinding: istio-reader-clusterrole-istio-system.istio-system checked successfully
✔ Role: istiod.istio-system checked successfully
✔ RoleBinding: istiod.istio-system checked successfully
✔ Service: istiod.istio-system checked successfully
✔ ServiceAccount: istiod.istio-system checked successfully
✔ ValidatingWebhookConfiguration: istio-validator-istio-system.istio-system checked successfully
Checked 15 custom resource definitions
Checked 2 Istio Deployments
✔ Istio is installed and verified successfully

```

</p>
</details>

- Uninstall Istio
```
istioctl uninstall --purge
```

## Prerequisite
- [Install gateway-api CRD's](https://istio.io/latest/docs/tasks/traffic-management/ingress/gateway-api/)

```
kubectl kustomize "https://github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.0.0" | kubectl apply -f -
```

- Install Prometheus and Grafan

```
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/grafana.yaml
```

# Dive in
- [lab1: Istio installation, upgrade & configuration](lab1/README.md)
- [lab2: Traffic management](lab2/README.md)
- [lab3: Resiliency and fault injection](lab3/README.md)
- [lab4: Securing workloads](lab4/README.md)
- [lab5: Advanced scenarios](lab5/README.md)
