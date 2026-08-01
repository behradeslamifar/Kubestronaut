# Kubernetes Certified Administration

Online resources that will help you prepare for taking the Kubernetes Certified Administrator Certification exam.

**Disclaimer**: This is not likely a comprehensive list as the exam will be a moving target with the fast pace of k8s development - please make a pull request if there something wrong or that should be added, or updated in here.

I tried to restrict the cross references of resources to [kubernetes.io](https://kubernetes.io). Youtube videos and other blog resources are optional; however, I still found them useful in my k8s learning journey.

Ensure you have the right version of Kubernetes documentation selected (e.g. v1.29 as of 29rd March 2024 exam) especially for API objects and annotations.

## Prepare a Lab
- [Kubernetes LAB](labs/README.md)

## Exam Objectives

These are the exam objectives you review and understand in order to pass the test.

* [github.com: CNCF Exam Curriculum repository ](https://github.com/cncf/curriculum)
* [linuxfoundation.org: CKA Home Page](https://training.linuxfoundation.org/certification/certified-kubernetes-administrator-cka/)
* [Resources allowed during the examp](https://docs.linuxfoundation.org/tc-docs/certification/certification-resources-allowed#certified-kubernetes-administrator-cka-and-certified-kubernetes-application-developer-ckad)

<details><summary>Storage 10%</summary>
<p>

- [Implement storage classes](https://kubernetes.io/docs/concepts/storage/storage-classes/) and [dynamic volume provisioning](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/)
- [Configure volume types, access modes and reclaim policies](https://kubernetes.io/docs/concepts/storage/volumes/)
- [Manage persistent volumes and persistent volume claims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

</p>
</details>

<details><summary>Troubleshooting 30%</summary>
<p>

- [Troubleshoot clusters and nodes](https://kubernetes.io/docs/tasks/debug/debug-cluster/)
  - [logging](https://kubernetes.io/docs/concepts/cluster-administration/logging/)
- [Troubleshoot cluster components](https://kubernetes.io/docs/tasks/debug/debug-cluster/)
- [Monitor cluster and application resource usage](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-usage-monitoring/)
- [Manage and evaluate container output streams]()
- [Troubleshoot services and networking]()

</p>
</details>

<details><summary>Workloads & Scheduling 15%</summary>
<p>

- [Understand application deployments and how to perform rolling update and rollbacks]()
- [Use ConfigMaps and Secrets to configure applications]()
- [Configure workload autoscaling]()
- [Understand the primitives used to create robust, self-healing, application deployments]()
- [Configure Pod admission and scheduling (limits, node affinity, etc.)]()

</p>
</details>

<details><summary>Cluster Architecture, Installation & Configuration 25%</summary>
<p>

- [Manage role based access control (RBAC)]()
- [Prepare underlying infrastructure for installing a Kubernetes cluster]()
- [Create and manage Kubernetes clusters using kubeadm]()
- [Manage the lifecycle of Kubernetes clusters]()
- [Implement and configure a highly-available control plane]()
- [Use Helm and Kustomize to install cluster components]()
- [Understand extension interfaces (CNI, CSI, CRI, etc.)]()
- [Understand CRDs, install and configure operators]()

</p>
</details>

<details><summary>Services & Networking 20%</summary>
<p>

- [Understand connectivity between Pods](https://kubernetes.io/docs/concepts/workloads/pods/#pod-networking)
- [Define and enforce Network Policies]()
- [Use ClusterIP, NodePort, LoadBalancer service types and endpoints]()
- [Use the Gateway API to manage Ingress traffic]()
- [Know how to use Ingress controllers and Ingress resources]()
- [Understand and use CoreDNS]()

</p>
</details>

## Practice Exam
* [CKA Practice Exam Environment](https://github.com/arush-sal/cka-practice-environment)

## Books
- [Kubernetes in Action](https://www.amazon.com/Kubernetes-Action-Second-Marko-Luk%C5%A1a/dp/1617297615)
- [Kubernetes Up & Running](https://www.amazon.com/Kubernetes-Running-Dive-Future-Infrastructure/dp/109811020X)
