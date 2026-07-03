# CKS Lab
Which topics you should practice to definitely pass the CKS exam? ([link](https://www.linkedin.com/feed/update/urn:li:activity:7426620395111460864?updateEntityUrn=urn%3Ali%3Afs_updateV2%3A%28urn%3Ali%3Aactivity%3A7426620395111460864%2CFEED_DETAIL%2CEMPTY%2CDEFAULT%2Cfalse%29)]

- Falco is huge - expect to fix broken rules or write new ones to detect specific behavior like shell access inside a container
-  Network Policies + Cilium are guaranteed - know both standard Kubernetes NetworkPolicies (Deny-All, Allow-Specific) and CiliumNetworkPolicy, since many exam clusters now run Cilium CNI
-  Trivy & SBOM - generating a Software Bill of Materials and scanning images with Trivy are standard tasks now
-  Kube-Bench - you'll need to run it or read a report and fix CIS Benchmark failures on Master/Worker nodes
-  Pod Security Admission - PSP is dead, know PSA labels like https://lnkd.in/dtr8guQa: restricted
-  AppArmor & Seccomp - loading AppArmor profiles on nodes and creating custom Seccomp JSON profiles to block specific syscalls (like chmod) are very common questions
-  Static analysis of Dockerfiles - spot issues like USER root, sudo usage, or ADD instead of COPY
-  Secrets Management - encrypting secrets at rest in etcd and managing RBAC access to secrets are core skills
-  Audit Logs - enabling and analyzing them ("Who accessed Secret X?") is standard
-  RuntimeClass / gVisor - creating a RuntimeClass for runsc is a classic question
-  Istio mTLS - don't over-study complex routing, just know how to enable sidecar injection and enforce mTLS on an existing mesh
-  Different runtimes, including Docker - practice to change Docker's config, etc

And speed matters - ideally you should solve any task under 5 minutes; also memorize flags which are used often because search something in the docs during the exam is a bit painful and time consuming

##
