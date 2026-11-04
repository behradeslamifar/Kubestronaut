# Mock Examp
Qeustions: 16
Duration: 2hrs
Type: Handson

Other mock exams:
- [githuh.com: CKA Exam](https://github.com/sandistorm/CKA-Certified-Kubernetes-Administrator-2022/blob/main/CKA%20Exam.md)
- [github.com: mock exams](https://github.com/theplatformlab/CKA-Certified-Kubernetes-Administrator/tree/main/mock-exams)

## Storage 10%
1. database deployment deleted by mistake. PV exist. create PVC and deploy database again with new pvc

2. add a sidecar with busybox image and tail command, create hostpath volume to  share logs between two

3. create storage class

## Troubleshooting 30%
1. cluster is not working. check which components not running and fix the issue.

## Workloads & Scheduling 15%
1. create HPA for the deployement. max pod is 4 and min is 1 . make sure that deployment decrease after 30 seconds

2. update current configmap and make it immutable

## Cluster Architecture, Installation & Configuration 25%
1. Install container service from .deb package and make sysctl config permanent
```
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
```

2. Cluster migrated from external etcd to etcd static pod. fix cluster to start working with etcd static pod


## Services & Networking 20%
1. create ingress for the deployment on default namespace

2. create clusterip and nodeport service for the deployment

3. create network policy that let access to front namespace to access backend namespace

3. We want to migrate from ingress to gatewayapi. create Gateway and Httproute and remove ingress. use ingress tls-secret to define https route
