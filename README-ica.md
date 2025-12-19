# Istio-Certified-Associate
Istio is Greek for **Sail**, an open source implementation of a service mesh founded by Google, IBM and Lyft. Istio was originally build to run on Kubernetes but was written from the perspective of being deployment-platform agnostic. (Istio in Action)

## Understanding Service Mesh and Istio
- [istio.io: Istio Architecture](https://istio.io/latest/docs/ops/deployment/architecture/)
- [istio.io: Concepts Documents](https://istio.io/latest/docs/concepts/)

### Istio Anatomy
Virtual service and Destination rule 
Gateway tomanage inbount and outbout traffic

#### Istio Objects Examples
<details><summary>Traffic Management</summary>
<p>


<details><summary>Virtual service</summary>
<p>

This is not a real example only mix mutiple example to keep as an example

```yaml
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
  - reviews # IP address, a DNS name, a short name (such as a Kubernetes service short name), wildcard ("*") prefixes
  http:
  - match:
    - headers:
        end-user:
          exact: jason
    route:
    - destination:
        host: reviews # a mesh service with proxies or a non-mesh service added using a service entry
        subset: v2
  - match:
    - uri:
        prefix: /ratings
    route:
    - destination:
        host: ratings
  - route:
    - destination:
        host: reviews
        subset: v1
      weight: 75
    - destination:
        host: reviews
        subset: v2
      weight: 25
  - route: # default routing rule
    - destination:
        host: reviews
        subset: v3
```

Timeout
```yaml
  http:
  - route:
    - destination:
        host: ratings
        subset: v1
    timeout: 10s
```

Retries
```yaml
  http:
  - route:
    - destination:
        host: ratings
        subset: v1
    retries:
      attempts: 3
      perTryTimeout: 2s
```

Circuit breakers
```yaml
spec:
  host: reviews
  subsets:
  - name: v1
    labels:
      version: v1
    trafficPolicy:
      connectionPool:
        tcp:
          maxConnections: 100
```

Fault injection (Can not be used with retry and timeout)
```yaml
  http:
  - fault:
      delay:
        percentage:
          value: 0.1
        fixedDelay: 5s
    route:
    - destination:
        host: ratings
        subset: v1
```

</p>
</details>

<details><summary>Destination rules</summary>
<p>

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: bookinfo-ratings
spec:
  host: ratings.prod.svc.cluster.local
  trafficPolicy: # default traffic policy
    loadBalancer:
      simple: LEAST_REQUEST # LEAST_REQUEST (default policy), RANDOM, ROUND_ROBIN
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
    trafficPolicy: # Subset specified policy
      loadBalancer:
        simple: ROUND_ROBIN
  - name: v3
    labels:
      version: v3
```

</p>
</details>

<details><summary>Ingress Gateway</summary>
<p>

```yaml
apiVersion: networking.istio.io/v1
kind: Gateway
metadata:
  name: ext-host-gwy
spec:
  selector:
    app: my-gateway-controller
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    hosts:
    - ext-host.example.com
    tls:
      mode: SIMPLE
      credentialName: ext-host-cert
```

```yaml
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: virtual-svc
spec:
  hosts:
  - ext-host.example.com
  gateways:
  - ext-host-gwy
```

</p>
</details>

<details><summary>Service Entry</summary>
<p>

- Redirect and forward traffic for external destinations, such as APIs consumed from the web, or traffic to services in legacy infrastructure.
- Define retry, timeout, and fault injection policies for external destinations.
- Run a mesh service in a Virtual Machine (VM) by adding VMs to your mesh.

```yaml
apiVersion: networking.istio.io/v1
kind: ServiceEntry
metadata:
  name: svc-entry
spec:
  hosts:
  - ext-svc.example.com
  ports:
  - number: 443
    name: https
    protocol: HTTPS
  location: MESH_EXTERNAL
  resolution: DNS
```

Its possible to define DestinationRule for this ServiceEntry

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: ext-res-dr
spec:
  host: ext-svc.example.com
  trafficPolicy:
    connectionPool:
      tcp:
        connectTimeout: 1s
```

</p>
</details>

<details><summary>Sidecars</summary>
<p>

only reach services running in the sme namespace and the Istio control plane (needed by Istio's egress and telemetry features)

```yaml
apiVersion: networking.istio.io/v1
kind: Sidecar
metadata:
  name: default
  namespace: bookinfo
spec:
  egress:
  - hosts:
    - "./*"
    - "istio-system/*"
```

</p>
</details>

</p>
</details>

<details><summary>Security</summary>
<p>

<details><summary>Peer Authentication</summary>
<p>

```yaml
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "example-peer-policy"
  namespace: "foo"
spec:
  selector:
    matchLabels:
      app: reviews
  mtls:
    mode: STRICT # PERMISSIVE, DISABLE
```

```yaml
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "example-workload-policy"
  namespace: "foo"
spec:
  selector:
     matchLabels:
       app: example-app
  portLevelMtls:
    80:
      mode: DISABLE
```

</p>
</details>

<details><summary>Authorization Policy</summary>
<p>

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
 name: httpbin
 namespace: foo
spec:
 selector:
   matchLabels:
     app: httpbin
     version: v1
 action: ALLOW
 rules:
 - from:
   - source:
       principals: ["cluster.local/ns/default/sa/sleep"]
   - source:
       namespaces: ["dev"]
   to:
   - operation:
       methods: ["GET"]
   when:
   - key: request.auth.claims[iss]
     values: ["https://accounts.google.com"]
```

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
 name: httpbin-deny
 namespace: foo
spec:
 selector:
   matchLabels:
     app: httpbin
     version: v1
 action: DENY
 rules:
 - from:
   - source:
       notNamespaces: ["foo"]
```

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: tester
  namespace: default
spec:
  selector:
    matchLabels:
      app: products
  action: ALLOW
  rules:
  - to:
    - operation:
        paths: ["/test/*", "*/info"]
```

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: allow-nothing
spec:
  action: ALLOW
  # the rules field is not specified, and the policy will never match.
```

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: deny-all
spec:
  action: DENY
  # the rules field has an empty rule, and the policy will always match.
  rules:
  - {}
```

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: allow-all
spec:
  action: ALLOW
  # This matches everything.
  rules:
  - {}
```


</p>
</details>

<details><summary>sa</summary>
<p>

</p>
</details>

<details><summary>sa</summary>
<p>

</p>
</details>

</p>
</details>

## Prepare a Lab
- [Istio Lab](labs/README.md)
- [killercoda.com: Scenario for the ICA](https://killercoda.com/ica)

## Exam Objectives

These are the exam objectives you review and understand in order to pass the test.

* [github.com: CNCF Exam Curriculum repository ](https://github.com/cncf/curriculum)
* [linuxfoundation.org: ICA Home Page](https://training.linuxfoundation.org/certification/istio-certified-associate-ica/)
* [Resources allowed during the examp](https://docs.linuxfoundation.org/tc-docs/certification/certification-resources-allowed#istio-certified-associate-ica)

<details><summary>Istio Installation, Upgrade & Configuration 7%</summary>
<p>

- [Using the Istio CLI to install a basic cluster](https://istio.io/latest/docs/setup/install/istioctl/)
  - [youtube.com: Mesh Week (Session 1)](https://www.youtube.com/watch?v=w_8Gg_jsAbU)
  - [istio.io: Installation Configuration Profiles](https://istio.io/latest/docs/setup/additional-setup/config-profiles/)
  - [istio.io: Introducing istiod: simplifying the control plane](https://istio.io/v1.16/blog/2020/istiod/)
- [Customizing the Istio installation with the IstioOperator API](https://istio.io/latest/docs/reference/config/istio.operator.v1alpha1/)
- [Using overlays to manage Istio component settings](https://istio.io/latest/docs/setup/additional-setup/customize-installation/#identify-an-istio-component)

</p>
</details>

<details><summary>Traffic Management 40%</summary>
<p>

- [Controlling network traffic flows within a service mesh](https://istio.io/latest/docs/tasks/traffic-management/request-routing/)
  - [youtube.com: Mesh Week (Session 2)](https://www.youtube.com/watch?v=Q-l1z3ejc8Q)
  - [solo.io: Istio Networking in Depth](https://www.solo.io/blog/istios-networking-in-depth/)
  - [istio.io: Traffic Shifting](https://istio.io/latest/docs/tasks/traffic-management/traffic-shifting/)
- [Configuring sidecar injection](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/)
- [Using the Gateway resource to configure ingress and egress traffic](https://istio.io/latest/docs/reference/config/networking/gateway/)
  - [istio.io: Egress Gateway](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/)
  - [istio.io: Virtualservice](https://istio.io/latest/docs/reference/config/networking/virtual-service/)
- [Understanding how to use ServiceEntry resources for adding entries to internal service registry](https://istio.io/latest/docs/reference/config/networking/service-entry/)
  - [solo.io: Istio multi-cluster traffic](https://www.solo.io/blog/istio-multi-cluster-traffic-debugging/)
- [Define traffic policies using DestinationRule](https://istio.io/latest/docs/reference/config/networking/destination-rule/)
- [Configure traffic mirroring capabilities](https://istio.io/latest/docs/tasks/traffic-management/mirroring/)
  - [envoyproxy.io: HTTP route components](https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/route/v3/route_components.proto#config-route-v3-routeaction-requestmirrorpolicy)

</p>
</details>

<details><summary>Resilience and Fault Injection 20%</summary>
<p>

- [Configuring circuit breakers (with or without outlier detection)](https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/)
- [Using resilience features](https://istio.io/latest/docs/concepts/traffic-management/#network-resilience-and-testing)
- [Creating fault injection](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/)
  - [istio.io: Fault injection](https://istio.io/latest/docs/concepts/traffic-management/#fault-injection)
  - [istio.io: Commands](https://istio.io/latest/docs/reference/commands/pilot-agent/)

</p>
</details>

<details><summary>Securing Workloads 20%</summary>
<p>

- [Understand Istio security features](https://istio.io/latest/docs/concepts/security/)
  - [youtube.com: Mesh Week (Session 4)](https://www.youtube.com/watch?v=uO-X1U1l23I)
- [Set up Istio authorization for HTTP/TCP traffic in the mesh](https://istio.io/latest/docs/reference/config/security/authorization-policy/)
  - [istio.io: HTTP Traffic (task for authorization policy)](https://istio.io/latest/docs/tasks/security/authorization/authz-http/)
- [Configure mutual TLS at mesh, namespace, and workload levels](https://istio.io/latest/docs/ops/configuration/traffic-management/tls-configuration/)
  - [istio.io: Mutual TLS Migration (task)](https://istio.io/latest/docs/tasks/security/authentication/mtls-migration/)

</p>
</details>

<details><summary>Advanced Scenarios 13%</summary>
<p>

- [Understand how to onboard non-Kubernetes workloads to the mesh](https://istio.io/latest/docs/setup/install/virtual-machine/)
  - [istio.io: Virtual Machine Artichitecture](https://istio.io/latest/docs/ops/deployment/vm-architecture/)
  - [istio.io: Bookinfo with a Virtual Machine (example)](https://istio.io/latest/docs/examples/virtual-machines/)
  - [youtube.com: Mesh Week (Session 5)](https://www.youtube.com/watch?v=Od7L-3tE9oA)
- [Troubleshoot configuration issues](https://istio.io/latest/docs/ops/common-problems/)

</p>
</details>

## Other resources
- [academy.solo.io: ServiceMesh and CNI  free courses](https://academy.solo.io/learn)
- [academy.tetrate.io: ServiceMesh free cources](https://academy.tetrate.io/collections)
- [github.com: Mesh Week Videos](https://github.com/solo-io/mesh-week)
- [github.com: Blog posts about ICA](https://github.com/yuyatinnefeld/istio?tab=readme-ov-file)
- [docs.google.com: Mock Istio Examp - Mesh Week](https://docs.google.com/forms/d/e/1FAIpQLSfD4BLLQfdUwnIyiTBSGC_OzmSbiyrIlNp5Am61fTOhRbfiLw/viewform)

## Books
- [Istio in Action](https://www.manning.com/books/istio-in-action)
- [Istio Up and Running](https://www.oreilly.com/library/view/istio-up-and/9781492043775/)
- [Bootstrapping Service Mesh Implementations with Istio](https://www.packtpub.com/product/bootstrapping-service-mesh-implementations-with-istio/9781803246819) (I dont recommend this book, not organize well)
