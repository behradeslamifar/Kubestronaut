# Kubernetes LAB
This page is about prepare a lab for install Kuberenetes with kubeadm for CKA practice. There are other ways to setup cluster also:
- [kind](kind.md)

## Install and Preparation

### Lab requirement
- [Install Virtualbox with Extention pack](https://www.virtualbox.org/wiki/Downloads)
- [Download Ubuntu Server 22.04](https://ubuntu.com/download/server#downloads)
- [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management)
- Install bash-completion
```
sudo apt install bash-completion
```
- Enable kubectl autocompletion 
```
echo 'source <(kubectl completion bash)' >>~/.bashrc
```

### Create a template node in Virtualbox
- Create and Install a virtualmachine with Ubuntu server image in Virtualbox
  - 2GB Memory
  - 2 Cpu Cores
- In the Ubuntu VM install following application
  - [Install containerd from docker repository](https://docs.docker.com/engine/install/ubuntu/)
  - [Install kubectl, kubeadm, kubelet](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl)
- [Configure prerequisites in the VM](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
  - enable ip_forward and bridge for iptables.
```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
```
  - Disable swap
```
swapoff /path/to/swap
sed -i 's/^\(.* swap .*\)$/#\1/' /etc/fstab
```
  - [Configure containerd for CRI](https://github.com/containerd/containerd/blob/main/docs/cri/config.md#full-configuration)

### First Master
Clone from your VM to Install first Master with kubeadm
