
# Certified Kubernetes Application Developer (CKAD)

_Before to start_ 

Ensure you have the right version of Kubernetes documentation selected (e.g. v1.31 as of 27th November. 2024 exam) especially for API objects and annotations. 

## Prepare a Lab
- [Kubernetes LAB](labs-ckad/README.md)

## Exam Objectives
These are the exam objectives you review and understand in order to pass the test.

* [github.com: CNCF Exam Curriculum repository ](https://github.com/cncf/curriculum)
* [linuxfoundation.org: CKAD Home Page](https://training.linuxfoundation.org/certification/certified-kubernetes-application-developer-ckad/)
* [Resources allowed during the examp](https://docs.linuxfoundation.org/tc-docs/certification/certification-resources-allowed#certified-kubernetes-administrator-cka-and-certified-kubernetes-application-developer-ckad)


<details><summary>Application Design and Build 20%</summary>
<p>

- [docs.docker.com: Define, build and modify container images](https://docs.docker.com/get-started/docker-concepts/building-images/understanding-image-layers/)
  - [Best Practices](https://docs.docker.com/build/building/best-practices/)
  - [kubernetes.io: Container Runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
- [Choose and use the right workload resource (Deployment, DaemonSet, CronJob, etc.)](https://kubernetes.io/docs/concepts/workloads/)
  - [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
  - [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
  - [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
  - [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
  - [Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
  - [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
- [Understand multi-container Pod design patterns (e.g. sidecar, init and others)](https://kubernetes.io/docs/concepts/workloads/pods/#how-pods-manage-multiple-containers)
  - [Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
  - [Sidecar Containers](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/)
  - [Ephemeral Containers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/)
- [Utilize persistent and ephemeral volumes](https://kubernetes.io/docs/concepts/storage/volumes/)
  - [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
  - [Ephemeral Volumes](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/)

</p>
</details>

<details><summary>Application Deployment 20%</summary>
<p>

- [Use Kubernetes primitives to implement common deployment strategies (e.g. blue/green or canary)](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
  - [Canary deployments](https://kubernetes.io/docs/concepts/workloads/management/#canary-deployments)
- [Understand Deployments and how to perform rolling updates](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/)
- [Use the Helm package manager to deploy existing packages](https://helm.sh/docs/helm/helm_install/)
- [Kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/)

</p>
</details>

<details><summary>Application Observability and Maintenance 15%</summary>
<p>

- [Understand API deprecations](https://kubernetes.io/docs/reference/using-api/deprecation-policy/)
  - [kubernetes.io: Deprecated API Migration Guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/)
- [Implement probes and health checks](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
- [Use built-in CLI tools to monitor Kubernetes applications](https://kubernetes.io/docs/tasks/debug/debug-application/)
- [Utilize container logs](https://kubernetes.io/docs/concepts/cluster-administration/logging/)
- [Debugging in Kubernetes](https://kubernetes.io/docs/tasks/debug/debug-cluster/)

</p>
</details>

<details><summary>Application Environment, Configuration and Security 25%</summary>
<p>

- [Discover and use resources that extend Kubernetes (CRD, Operators)](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/)
  - [cncf.io: Kubernetes Operators: what are they? Some examples](https://www.cncf.io/blog/2022/06/15/kubernetes-operators-what-are-they-some-examples/)
  - [rx-m.com: Discover and Use Resources that Extend Kubernetes](https://rx-m.com/lesson/ckad-discover-and-use-resources-that-extend-kubernetes/)
  - [medium.com: Extending Kubernetes with Custom Resources and Custom Resource Definitions (CRDs)](https://medium.com/@priyamsanodiya340/extending-kubernetes-with-custom-resources-and-custom-resource-definitions-crds-fec7297db2e0)
- [Understand authentication, authorization and admission control](https://kubernetes.io/docs/reference/access-authn-authz/)
  - [learnk8s.io: Authentication and authorization in Kubernetes](https://learnk8s.io/auth-authz)
- [Understand requests, limits, quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
  - [kubernetes.io: Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/)
- [Understand ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)
- [Define resource requirements](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
- [Create & consume Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- [Understand ServiceAccounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
  - [kubernetes.io: Configure Service Account for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)
- [Understand Application Security (SecurityContexts, Capabilities, etc.)](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
  - [kubernetes.io: Cloud Native Security and Kubernetes](https://kubernetes.io/docs/concepts/security/cloud-native-security/)

</p>
</details>

<details><summary>Services and Networking 20%</summary>
<p>

- [Demonstrate basic understanding of NetworkPolicies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Provide and troubleshoot access to applications via services]()
- [Use Ingress rules to expose applications](https://kubernetes.io/docs/concepts/services-networking/ingress/)
  - [kubernetes.io: Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
  - [kubernates.io: Gateway API](https://kubernetes.io/docs/concepts/services-networking/gateway/)

</p>
</details>

## Practice Exam
- [killer.sh: ckad](https://killer.sh/ckad)
- [learning.oreilly.com: Labs](https://learning.oreilly.com/playlists/2e9fe6dc-2a05-47fe-ae0a-34d6485287cc/)

## Online Courses
- [linkedin.com: Certified Kubernetes Application Developer (CKAD) Exam Tips](https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-cert-prep-exam-tips)

## Books
- [Certified Kubernetes Application Developer (CKAD) Study Guide, 2nd Edition](https://www.oreilly.com/library/view/certified-kubernetes-application/9781098152857/)
