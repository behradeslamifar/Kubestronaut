
# Certified Kubernetes Application Developer (CKAD)

_Before to start_ 

Ensure you have the right version of Kubernetes documentation selected (e.g. v1.31 as of 27th November. 2024 exam) especially for API objects and annotations. This release removes several deprecated API's. 

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
  - [Side Containers](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/)
  - [Ephemeral Containers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/)
- [Utilize persistent and ephemeral volumes](https://kubernetes.io/docs/concepts/storage/volumes/)
  - [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
  - [Ephemeral Volumes](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/)

</p>
</details>

<details><summary>Application Deployment 20%</summary>
<p>

- [Use Kubernetes primitives to implement common deployment strategies (e.g. blue/green or canary)]()
- [Understand Deployments and how to perform rolling updates]()
- [Use the Helm package manager to deploy existing packages]()
- [Kustomize]()

</p>
</details>

<details><summary>Application Observability and Maintenance 15%</summary>
<p>

- [Understand API deprecations]()
- [Implement probes and health checks]()
- [Use built-in CLI tools to monitor Kubernetes applications]()
- [Utilize container logs]()
- [Debugging in Kubernetes]()

</p>
</details>

<details><summary>Application Environment, Configuration and Security 25%</summary>
<p>

- [Discover and use resources that extend Kubernetes (CRD, Operators)]()
- [Understand authentication, authorization and admission control]()
- [Understand requests, limits, quotas]()
- [Understand ConfigMaps]()
- [Define resource requirements]()
- [Create & consume Secrets]()
- [Understand ServiceAccounts]()
- [Understand Application Security (SecurityContexts, Capabilities, etc.)]()

</p>
</details>

<details><summary>Services and Networking 20%</summary>
<p>

- [Demonstrate basic understanding of NetworkPolicies]()
- [Provide and troubleshoot access to applications via services]()
- [Use Ingress rules to expose applications]()

</p>
</details>

## Practice Exam
- [killer.sh: ckad](https://killer.sh/ckad)
- [learning.oreilly.com: Labs](https://learning.oreilly.com/playlists/2e9fe6dc-2a05-47fe-ae0a-34d6485287cc/)

## Online Courses
- [linkedin.com: Certified Kubernetes Application Developer (CKAD) Exam Tips](https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-cert-prep-exam-tips)

## Books
- [Certified Kubernetes Application Developer (CKAD) Study Guide, 2nd Edition](https://www.oreilly.com/library/view/certified-kubernetes-application/9781098152857/)
