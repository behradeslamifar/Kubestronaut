# Istio installation, upgrade & configuration

## Overlaid default config
Overlaid `demo` profile
- Create overlay file: pilot-overlay.yaml
```
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  components:
    pilot:
      k8s:
        resources:
          requests:
            cpu: 1000m # override from default 500m
            memory: 4096Mi # ... default 2048Mi
        hpaSpec:
          maxReplicas: 10 # ... default 5
          minReplicas: 2  # ... default 1
```

- Install with istioctl
```
istioctl install --set profile=demo -f pilot-overlay.yaml
```


### Another overlay file for k8s configs
```
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  profile: empty
  hub: docker.io/istio
  tag: 1.1.6
  components:
    pilot:
      enabled: true
      namespace: istio-control
      k8s:
        overlays:
          - kind: Deployment
            name: istiod
            patches:
              # Select list item by value
              - path: spec.template.spec.containers.[name:discovery].args.[30m]
                value: "60m" # overridden from 30m
              # Select list item by key:value
              - path: spec.template.spec.containers.[name:discovery].ports.[containerPort:8080].containerPort
                value: 1234
              # Override with object (note | on value: first line)
              - path: spec.template.spec.containers.[name:discovery].env.[name:POD_NAMESPACE].valueFrom
                value: |
                  fieldRef:
                    apiVersion: v2
                    fieldPath: metadata.myPath
              # Deletion of list item
              - path: spec.template.spec.containers.[name:discovery].env.[name:REVISION]
              # Deletion of map item
              - path: spec.template.spec.containers.[name:discovery].securityContext
          - kind: Service
            name: istiod
            patches:
              - path: spec.ports.[name:https-dns].port
                value: 11111 # OVERRIDDEN
```
