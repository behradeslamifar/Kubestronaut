# Install a basic cluster with kubeadm
We use `kubeadm init` and `kubeadm join` to initiate a cluster and join other nodes to the cluster.
- [More information about kubeadm arguments](https://kubernetes.io/docs/reference/setup-tools/kubeadm/)
- [Using kubeadm init with configuration file](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#config-file)

> [!IMPORTANT]
> we have a long running problem of not having a good mapping between flags and config.

## Initial Kubernetes Master Node without kubeadm config
```
user@master1:~$ sudo kubeadm  init --apiserver-advertise-address=192.168.88.100 \
                       --control-plane-endpoint=192.168.88.100:6443 --upload-certs

...
To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join 192.168.88.100:6443 --token g7eyg1.6w664drzevp5n4ws \
	--discovery-token-ca-cert-hash sha256:c2d56f6541f1ddfb7b0606d6cd058ace2cf7f8b7a0380a164d30af5e7a02b064 \
	--control-plane --certificate-key 226614192d10b49ae8b3ccf724f75094e867bc214fb6566ce0260d672d4d7560

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.88.100:6443 --token g7eyg1.6w664drzevp5n4ws \
	--discovery-token-ca-cert-hash sha256:c2d56f6541f1ddfb7b0606d6cd058ace2cf7f8b7a0380a164d30af5e7a02b064 
```

<details><summary>Update default config.toml with these</summary>
<p>

```
apiVersion: kubeadm.k8s.io/v1beta3
bootstrapTokens:
- groups:
  - system:bootstrappers:kubeadm:default-node-token
  token: abcdef.0123456789abcdef
  ttl: 24h0m0s
  usages:
  - signing
  - authentication
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: 1.2.3.4
  bindPort: 6443
nodeRegistration:
  criSocket: unix:///var/run/containerd/containerd.sock
  imagePullPolicy: IfNotPresent
  name: node
  taints: null
---
apiServer:
  timeoutForControlPlane: 4m0s
apiVersion: kubeadm.k8s.io/v1beta3
certificatesDir: /etc/kubernetes/pki
clusterName: kubernetes
controllerManager: {}
dns: {}
etcd:
  local:
    dataDir: /var/lib/etcd
imageRepository: registry.k8s.io
kind: ClusterConfiguration
kubernetesVersion: 1.29.0
networking:
  dnsDomain: cluster.local
  serviceSubnet: 10.96.0.0/12
scheduler: {}
---
apiVersion: kubeproxy.config.k8s.io/v1alpha1
bindAddress: 0.0.0.0
bindAddressHardFail: false
clientConnection:
  acceptContentTypes: ""
  burst: 0
  contentType: ""
  kubeconfig: /var/lib/kube-proxy/kubeconfig.conf
  qps: 0
clusterCIDR: ""
configSyncPeriod: 0s
conntrack:
  maxPerCore: null
  min: null
  tcpBeLiberal: false
  tcpCloseWaitTimeout: null
  tcpEstablishedTimeout: null
  udpStreamTimeout: 0s
  udpTimeout: 0s
detectLocal:
  bridgeInterface: ""
  interfaceNamePrefix: ""
detectLocalMode: ""
enableProfiling: false
healthzBindAddress: ""
hostnameOverride: ""
iptables:
  localhostNodePorts: null
  masqueradeAll: false
  masqueradeBit: null
  minSyncPeriod: 0s
  syncPeriod: 0s
ipvs:
  excludeCIDRs: null
  minSyncPeriod: 0s
  scheduler: ""
  strictARP: false
  syncPeriod: 0s
  tcpFinTimeout: 0s
  tcpTimeout: 0s
  udpTimeout: 0s
kind: KubeProxyConfiguration
logging:
  flushFrequency: 0
  options:
    json:
      infoBufferSize: "0"
  verbosity: 0
metricsBindAddress: ""
mode: ""
nftables:
  masqueradeAll: false
  masqueradeBit: null
  minSyncPeriod: 0s
  syncPeriod: 0s
nodePortAddresses: null
oomScoreAdj: null
portRange: ""
showHiddenMetricsForVersion: ""
winkernel:
  enableDSR: false
  forwardHealthCheckVip: false
  networkName: ""
  rootHnsEndpointName: ""
  sourceVip: ""
---
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 0s
    enabled: true
  x509:
    clientCAFile: /etc/kubernetes/pki/ca.crt
authorization:
  mode: Webhook
  webhook:
    cacheAuthorizedTTL: 0s
    cacheUnauthorizedTTL: 0s
cgroupDriver: systemd
clusterDNS:
- 10.96.0.10
clusterDomain: cluster.local
containerRuntimeEndpoint: ""
cpuManagerReconcilePeriod: 0s
evictionPressureTransitionPeriod: 0s
fileCheckFrequency: 0s
healthzBindAddress: 127.0.0.1
healthzPort: 10248
httpCheckFrequency: 0s
imageMaximumGCAge: 0s
imageMinimumGCAge: 0s
kind: KubeletConfiguration
logging:
  flushFrequency: 0
  options:
    json:
      infoBufferSize: "0"
  verbosity: 0
memorySwap: {}
nodeStatusReportFrequency: 0s
nodeStatusUpdateFrequency: 0s
resolvConf: /run/systemd/resolve/resolv.conf
rotateCertificates: true
runtimeRequestTimeout: 0s
shutdownGracePeriod: 0s
shutdownGracePeriodCriticalPods: 0s
staticPodPath: /etc/kubernetes/manifests
streamingConnectionIdleTimeout: 0s
syncFrequency: 0s
volumeStatsAggPeriod: 0s

```
</p>
</details>

## Initial Kubernetes Master Node with kubeadm config
Generate default config file

```
kubeadm config print init-defaults --component-configs KubeProxyConfiguration,KubeletConfiguration
```


and change base on your requirement
<details><summary>Update default config.toml with these</summary>
<p>

```
```

</p>

