
# Certified Kubernetes Security Specialist (CKS)

_Before to start_ 


## Prepare a Lab
- [Kubernetes LAB](labs-cks/README.md)

## Exam Objectives
These are the exam objectives you review and understand in order to pass the test.

* [github.com: CNCF Exam Curriculum repository ](https://github.com/cncf/curriculum)
* [linuxfoundation.org: CKS Home Page](https://training.linuxfoundation.org/certification/certified-kubernetes-security-specialist/)
* [Resources allowed during the examp](https://docs.linuxfoundation.org/tc-docs/certification/certification-resources-allowed#certified-kubernetes-administrator-cka-and-certified-kubernetes-application-developer-ckad)


<details><summary>Cluster Setup 15%</summary>
<p>

- [Use Network security policies to restrict cluster level access]()
- [Use CIS benchmark to review the security configuration of Kubernetes components (etcd, kubelet, kubedns, kubeapi)]()
- [Properly set up Ingress with TLS]()
- [Protect node metadata and endpoints]()
- [Verify platform binaries before deploying]()

</p>
</details>

<details><summary>Cluster Hardening 15%</summary>
<p>

- [Use Role Based Access Controls to minimize exposure]()
- [Exercise caution in using service accounts e.g. disable defaults, minimize permissions on newly created ones]()
- [Restrict access to Kubernetes API]()
- [Upgrade Kubernetes to avoid vulnerabilities]()

</p>
</details>

<details><summary>System Hardening 10%</summary>
<p>

- [Minimize host OS footprint (reduce attack surface)]()
- [Using least-privilege identity and access management]()
- [Minimize external access to the network]()
- [Appropriately use kernel hardening tools such as AppArmor, seccomp]()

</p>
</details>

<details><summary>Minimize Microservice Vulnerabilities 20%</summary>
<p>

- [Use appropriate pod security standards]()
- [Manage Kubernetes secrets]()
- [Understand and implement isolation techniques (multi-tenancy, sandboxed containers, etc.)]()
- [Implement Pod-to-Pod encryption using Cilium]()

</p>
</details>

<details><summary>Supply Chain Security 20%</summary>
<p>

- [Minimize base image footprint]()
- [Understand your supply chain (e.g. SBOM, CI/CD, artifact repositories)]()
- [Secure your supply chain (permitted registries, sign and validate artifacts, etc.)]()
- [Perform static analysis of user workloads and container images (e.g. Kubesec, KubeLinter)]()

</p>
</details>

<details><summary>Monitoring, Logging and Runtime Security 20%</summary>
<p>

- [Perform behavioral analytics to detect malicious activities]()
- [Detect threats within physical infrastructure, apps, networks, data, users and workloads]()
- [Investigate and identify phases of attack and bad actors within the environment]()
- [Ensure immutability of containers at runtime]()
- [Use Kubernetes audit logs to monitor access]()

</p>
</details>

## Practice Exam
- [killer.sh: cks](https://killer.sh/cks)
- [learning.oreilly.com: Labs](https://learning.oreilly.com/playlists/2e9fe6dc-2a05-47fe-ae0a-34d6485287cc/)

## Online Courses
- [linkedin.com: Kubernetes and Cloud Native Associate (KCNA) Cert Prep](https://www.linkedin.com/learning/kubernetes-and-cloud-native-associate-kcna-cert-prep)

## Books
- [oreilly.com: Certified Kubernetes Security Specialist (CKS) Study Guide](https://www.oreilly.com/library/view/certified-kubernetes-security/9781098132965/)

