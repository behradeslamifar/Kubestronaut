# Kustomize
kustomize is an implementation of declarative application management (DAM). 

A kustomization file contains fields falling into four categories:
- `resources` - what existing resources are to be customized. Example fields: resources, crds.
- `generators` - what new resources should be created. Example fields: configMapGenerator (legacy), secretGenerator (legacy), generators (v2.1).
- `transformers` - what to do to the aforementioned resources. Example fields: namePrefix, nameSuffix, images, commonLabels, patchesJson6902, etc. and the more general transformers (v2.1) field.
- `meta` - fields which may influence all or some of the above. Example fields: vars, namespace, apiVersion, kind, etc.



## Create common layout
```bahs
mkdir {base,overlays}
touch base/{kustomization.yaml,deployment.yaml,service.yaml}
touch overlays/{dev,staging,prod}/{kustomization.yaml,patch.yaml}
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
