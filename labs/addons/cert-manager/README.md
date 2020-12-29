# Cert-manager
Test environment:  
`appVersion:` v1.1.0  
`sources:` https://github.com/jetstack/cert-manager  
`version:` v1.1.0  

## Install cert-manager on Kubernetes
You can find installation manual with helm at [this link](https://cert-manager.io/docs/installation/kubernetes/#installing-with-helm).  
If you in Iran you must use proxy to install cert-manager:  
```
http_proxy="http://user:password@proxy.example.com:3128/" helm repo add jetstack https://charts.jetstack.io
http_proxy="http://user:password@proxy.example.com:3128/" helm repo update
```

cert-manager requires a number of CRD resources, that can be installed with helm or manifests.  
Install CDR resources with helm:  
```
$ http_proxy="http://user:password@proxy.example.com:3128/" helm pull jetstack/cert-manager --untar
$ sed -i 's/^installCRDs:.*$/installCRDs: true/' cert-manager/values.yaml
$ kubectl create namespace cert-manager
$ http_proxy="http://user:password@proxy.example.com:3128/" helm install cert-manager cert-manager --namespace cert-manager --debug
install.go:158: [debug] Original chart version: ""
install.go:175: [debug] CHART PATH: /home/behrad/Behrad_Eslamifar/Projects/Cafebazaar/Casio/desktop/cert-manager

client.go:98: [debug] creating 38 resource(s)
NAME: cert-manager
LAST DEPLOYED: Mon Dec 28 13:57:22 2020
NAMESPACE: cert-manager
STATUS: deployed
REVISION: 1
TEST SUITE: None
USER-SUPPLIED VALUES:
{}
...
```

## Install Let's encrypt Issuer

