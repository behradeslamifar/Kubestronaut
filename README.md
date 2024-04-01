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

<details><summary>Cluster Architecture, Installation & Configuration 25%</summary>
<p>

- [Manage role based access control (RBAC)](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Use Kubeadm to install a basic cluster](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
- [Manage a highly-available Kubernetes cluster](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)
- [Provision underlying infrastructure to deploy a Kubernetes cluster](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
- [Perform a version upgrade on a Kubernetes cluster using Kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-upgrade/)
- [Implement etcd backup and restore](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster)

</p>
</details>

<details><summary>Workloads & Scheduling 15%</summary>
<p>

- [Understand deployments and how to perform rolling update and rollbacks](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- Use [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/) and [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/) to configure applications
- Know how to scale applications
  - [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#scaling-a-deployment)
  - [Statefulset](https://kubernetes.io/docs/tasks/run-application/scale-stateful-set/)
  - [Replicaset](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/#scaling-a-replicaset)
- Understand the primitives used to create robust, self-healing, application deployments
  - [Replicaset](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
  - [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
  - [Statefulset](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
  - [Daemonset](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
- [Understand how resource limits can affect Pod scheduling](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#how-pods-with-resource-requests-are-scheduled)
- Awareness of manifest management and common templating tools
  - Helm
  - [Kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/)

</p>
</details>

<details><summary>Services & Networking 20%</summary>
<p>

- [Understand host networking configuration on the cluster nodes](https://kubernetes.io/docs/concepts/cluster-administration/networking/)
- [Understand connectivity between Pods](https://kubernetes.io/docs/concepts/workloads/pods/#pod-networking)
- [Understand ClusterIP, NodePort, LoadBalancer service types and endpoints](https://kubernetes.io/docs/concepts/services-networking/service/)
- Know how to use [Ingress controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) and [Ingress resources](https://kubernetes.io/docs/concepts/services-networking/ingress/#the-ingress-resource)
- [Know how to configure and use CoreDNS](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)
- [Choose an appropriate container network interface plugin](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network)

</p>
</details>

<details><summary>Storage 10%</summary>
<p>

- Understand [storage classes](https://kubernetes.io/docs/concepts/storage/storage-classes/), [persistent volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
- Understand [volume mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-mode), [access modes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) and [reclaim policies](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaim-policy) for volumes
- [Understand persistent volume claims primitive](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims)
- [Know how to configure applications with persistent storage](https://kubernetes.io/docs/tasks/configure-pod-container/configure-volume-storage/)

</p>
</details>

<details><summary>Troubleshooting 30%</summary>
<p>

- [Evaluate cluster and node logging](https://kubernetes.io/docs/concepts/cluster-administration/logging/)
- [Understand how to monitor applications](https://kubernetes.io/docs/tasks/debug-application-cluster/resource-usage-monitoring/)
- [Manage container stdout & stderr logs](https://kubernetes.io/docs/concepts/cluster-administration/logging/#logging-at-the-node-level)
- [Troubleshoot application failure](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/)
  - [Pending and Terminated Pods](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#troubleshooting)
- [Troubleshoot cluster component failure](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster/)
- [Troubleshoot networking](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster/)
  - [DNS Troubleshooting](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/)

</p>
</details>

## Practice Exam
* [CKA Practice Exam Environment](https://github.com/arush-sal/cka-practice-environment)

## Books
- [Kubernetes in Action](https://www.amazon.com/Kubernetes-Action-Second-Marko-Luk%C5%A1a/dp/1617297615)
- [Kubernetes Up & Running](https://www.amazon.com/Kubernetes-Running-Dive-Future-Infrastructure/dp/109811020X)
