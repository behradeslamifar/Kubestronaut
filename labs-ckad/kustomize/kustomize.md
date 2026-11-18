# Kustomize
kustomize is an implementation of declarative application management (DAM). 

A kustomization file contains fields falling into four categories:
- `resources` - what existing resources are to be customized. Example fields: resources, crds.
- `generators` - what new resources should be created. Example fields: configMapGenerator (legacy), secretGenerator (legacy), generators (v2.1).
- `transformers` - what to do to the aforementioned resources. Example fields: namePrefix, nameSuffix, images, commonLabels, patchesJson6902, etc. and the more general transformers (v2.1) field.
- `meta` - fields which may influence all or some of the above. Example fields: vars, namespace, apiVersion, kind, etc.


Kustomize Pipeline Diagram by ChatGPT
```sql
             +-------------------------+
             |   META (configuration)  |
             | apiVersion, kind        |
             | configurations, vars    |
             | openapi, namespace      |
             +------------+------------+
                          |
                          v
        +-----------------+-------------------+
        |       RESOURCES (input manifests)   |
        |    - deployment.yaml                |
        |    - service.yaml                   |
        |    - CRDs                           |
        +-----------------+-------------------+
                          |
                          v
        +-----------------+-------------------+
        |     GENERATORS (produce resources)  |
        |    - configMapGenerator             |
        |    - secretGenerator                |
        |    - helmCharts                     |
        |    - plugins                        |
        +-----------------+-------------------+
                          |
                          v
        +-----------------+-------------------+
        |    TRANSFORMERS (mutate resources)  |
        |    - labels                         |
        |    - annotations                    |
        |    - patches                        |
        |    - images                         |
        |    - replacements                   |
        |    - namePrefix/suffix              |
        +-----------------+-------------------+
                          |
                          v
        +-----------------+-------------------+
        |            FINAL OUTPUT YAML        |
        +-------------------------------------+

```

## Create common layout
```bahs
mkdir -p webapp/{base,overlays}
mkdir webapp/{dev,stage,prod}
```

Create deployment template: webapp/base/deployment.yaml
```yaml
```

Create servcie template: webapp/base/service.yaml
```yaml
```

Create kustomization.yaml
```bash
kustomize create --autodetect 
```

## Commands
Generate manifests by templates
```bash
kubectl kustomize <folder>
```

Deploy
```bash
kubectl apply -k <folder>
kubectl create -k <folder>
```

Diffing Local and Remote Resources
```bash
kubectl diff -k <folder>
```

## kustomization.yaml example from ChatGPT
```yaml
# --------------------------------------------------------------
# KUSTOMIZATION ROOT
# --------------------------------------------------------------
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization


# --------------------------------------------------------------
# APPLIED TO ALL MANIFESTS
# --------------------------------------------------------------

# Add a prefix to all resource names
namePrefix: demo-

# Add a suffix to resource names
nameSuffix: -v1

# Add labels to all resources (new style transformer)
labels:
  - pairs:
      app.kubernetes.io/managed-by: kustomize
      app.kubernetes.io/part-of: demo-app
    includeSelectors: false       # do not modify matchLabels
    includeTemplates: false       # do not modify pod template labels

# Add annotations to all resources
annotations:
  - pairs:
      owner: platform-team
      purpose: learning


# --------------------------------------------------------------
# RESOURCE LIST (These YAMLs will be included)
# --------------------------------------------------------------
resources:
  - deployment.yaml
  - service.yaml
  - ingress.yaml
  - namespace.yaml


# --------------------------------------------------------------
# CONFIGMAP & SECRET GENERATORS
# --------------------------------------------------------------

configMapGenerator:
  - name: demo-config
    literals:
      - LOG_LEVEL=info
    files:
      - config/app.properties
    envs:
      - config/app.env

secretGenerator:
  - name: demo-secret
    literals:
      - password=supersecret
    files:
      - secrets/private.pem
    type: Opaque


# Options applied to all generators
generatorOptions:
  disableNameSuffixHash: true
  annotations:
    generated-by: kustomize


# --------------------------------------------------------------
# IMAGES (modify images inside resources)
# --------------------------------------------------------------

images:
  - name: demo-api
    newName: my.registry.io/demo-api
    newTag: "1.2.3"
  - name: busybox
    newTag: "1.36"


# --------------------------------------------------------------
# PATCHES (Strategic Merge & JSON6902)
# --------------------------------------------------------------

# Strategic merge patch
patchesStrategicMerge:
  - patches/deployment-replicas.yaml
  - patches/add-probes.yaml

# JSON6902 patch (exact, surgical patching)
patchesJson6902:
  - target:
      group: apps
      version: v1
      kind: Deployment
      name: demo-api
    path: patches/json/update-resources.json


# --------------------------------------------------------------
# REPLACEMENTS (Modern variable replacement system)
# --------------------------------------------------------------

replacements:
  - source:
      kind: ConfigMap
      name: demo-config
      fieldPath: data.LOG_LEVEL
    targets:
      - select:
          kind: Deployment
          name: demo-api
        fieldPaths:
          - spec.template.spec.containers.[name=api].env.[name=LOG_LEVEL].value


# --------------------------------------------------------------
# TRANSFORMER CONFIG (optional custom config directories)
# --------------------------------------------------------------
# These directories contain transformer plugins or configs.
# They are *not* common for everyday use, but valid.

transformers:
  - transformers/common-labels.yaml
  - transformers/custom-transformer.yaml


# --------------------------------------------------------------
# CONFIGURATION DIRECTIVES (for legacy systems like vars:)
# --------------------------------------------------------------

# Vars are deprecated but still supported
vars:
  - name: APP_NAME
    objref:
      kind: ConfigMap
      name: demo-config
      apiVersion: v1
    fieldref:
      fieldpath: data.APP_NAME

# Configuration for legacy transformers (optional)
configurations:
  - kustomizeconfig.yaml

# --------------------------------------------------------------
# COMPONENTS (Re-usable partial overlays)
# --------------------------------------------------------------

components:
  - components/monitoring
  - components/logging

# --------------------------------------------------------------
# DEPLOYMENT TARGETS (Helm charts via builtin plugin)
# --------------------------------------------------------------

helmCharts:
  - name: nginx
    repo: https://charts.bitnami.com/bitnami
    version: 15.0.1
    releaseName: demo-nginx
    namespace: default
    valuesFile: helm/nginx-values.yaml


# --------------------------------------------------------------
# OPENAPI PATCHING (advanced use)
# --------------------------------------------------------------

openapi:
  path: openapi/custom-schema.json
```


## Transformers example by ChatGPT
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

# --------------------------------------------------------------
# 1. LABEL TRANSFORMER (modern)
# --------------------------------------------------------------
# Adds labels to resources. You can control whether selectors
# and pod templates get updated.
labels:
  - pairs:
      env: dev
      managed-by: kustomize
    includeSelectors: false      # Do NOT modify matchLabels
    includeTemplates: false      # Do NOT modify pod template labels


# --------------------------------------------------------------
# 2. ANNOTATION TRANSFORMER (modern)
# --------------------------------------------------------------
annotations:
  - pairs:
      owner: platform-team
      contact: ops@example.com


# --------------------------------------------------------------
# 3. NAME PREFIX & SUFFIX TRANSFORMERS
# --------------------------------------------------------------
namePrefix: demo-
nameSuffix: -v1
# These modify *resource names*, not labels or selectors.


# --------------------------------------------------------------
# 4. IMAGE TRANSFORMER (modern)
# --------------------------------------------------------------
# Rewrites container images across manifests.
images:
  - name: api
    newName: my.registry.io/api
    newTag: "2.0.0"

  - name: busybox
    newTag: "1.36"


# --------------------------------------------------------------
# 5. PATCH STRATEGIC MERGE
# --------------------------------------------------------------
# Best for typical Kubernetes resource patches.
patchesStrategicMerge:
  - patches/add-probes.yaml
  - patches/update-resources.yaml


# --------------------------------------------------------------
# 6. JSON6902 PATCHES (surgical patches)
# --------------------------------------------------------------
patchesJson6902:
  - target:
      group: apps
      version: v1
      kind: Deployment
      name: api
    path: patches/replicas.yaml

replicas.yaml
```
  - op: replace # override the replicas default value
    path: /spec/replicas
    value: 3
```

# --------------------------------------------------------------
# 7. REPLACEMENTS — modern variable injection
# --------------------------------------------------------------
# This is the *recommended* way to apply dynamic values.
replacements:
  - source:
      kind: ConfigMap
      name: app-config
      fieldPath: data.LOG_LEVEL
    targets:
      - select:
          kind: Deployment
          name: api
        fieldPaths:
          - spec.template.spec.containers.[name=api].env.[name=LOG_LEVEL].value


# --------------------------------------------------------------
# 8. NAMESPACE TRANSFORMER
# --------------------------------------------------------------
namespace: demo-space


# --------------------------------------------------------------
# 9. REPLICAS TRANSFORMER (modern)
# --------------------------------------------------------------
replicas:
  - name: api
    count: 3


# --------------------------------------------------------------
# 10. CONFIGMAP/SECRET GENERATORS (not transformers but essential)
# --------------------------------------------------------------
configMapGenerator:
  - name: app-config
    literals:
      - LOG_LEVEL=debug

secretGenerator:
  - name: app-secret
    literals:
      - password=supersecret

generatorOptions:
  disableNameSuffixHash: true


# --------------------------------------------------------------
# 11. HELM CHART TRANSFORMER (builtin helm inflation)
# --------------------------------------------------------------
helmCharts:
  - name: nginx
    repo: https://charts.bitnami.com/bitnami
    releaseName: nginx
    version: 15.0.1
    valuesFile: helm/nginx-values.yaml


# --------------------------------------------------------------
# 12. COMPONENTS (transformer bundles)
# --------------------------------------------------------------
components:
  - components/logging
  - components/monitoring


# --------------------------------------------------------------
# 13. LEGACY TRANSFORMERS (STILL WORK BUT DEPRECATED)
# --------------------------------------------------------------

# Deprecated: commonLabels (use modern 'labels:' instead)
# commonLabels:
#   app: my-app

# Deprecated: commonAnnotations
# commonAnnotations:
#   deprecated-example: "true"

# Deprecated: vars
# vars:
#   - name: APP_NAME
#     objref:
#       kind: ConfigMap
#       name: app-config
#       apiVersion: v1
#     fieldref:
#       fieldpath: data.APP_NAME


# --------------------------------------------------------------
# 14. CUSTOM TRANSFORMERS (KRM functions or plugins)
# --------------------------------------------------------------
transformers:
  - transformers/add-sidecar.yaml
  - transformers/enforce-security.yaml

```
