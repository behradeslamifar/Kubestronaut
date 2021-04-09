#!/usr/bin/env sh

KUBE_VERSION=1.20.5-00
DOCKER_VERSION=5:20.10.5~3-0~ubuntu-bionic
CONTAINERD_VERSION=1.4.4-1

# disable translate download and add proxy
cat <<EOF | sudo tee /etc/apt/apt.conf.d/20translate
Acquire::Languages "none";
EOF

cat <<EOF | sudo tee /etc/apt/apt.conf.d/21proxy
Acquire::http::proxy::download.docker.com "http://user:pass@proxy.example.com:3128/";
Acquire::http::proxy::apt.kubernetes.io "http://user:pass@proxy.example.com:3128/";
Acquire::http::proxy::packages.cloud.google.com "http://user:pass@proxy.example.com:3128/";
EOF

# Install Kuberntes components
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FEEA9169307EA071
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Install Docker
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 7EA0A9C3F273FCD8
cat <<EOF | sudo tee /etc/apt/sources.list.d/docker.list
deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable
EOF

sudo apt-get update
sudo apt-get install -y kubelet=$KUBE_VERSION kubeadm=$KUBE_VERSION kubectl=$KUBE_VERSION docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION
sudo apt-mark hold kubelet kubeadm kubectl docker-ce docker-ce-cli
sudo apt-get clean

# Set up the Docker daemon
cat <<EOF | sudo tee /etc/docker/daemon.json 
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Add proxy to Docker
sudo mkdir -p /etc/systemd/system/docker.service.d
cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf
[Service]
Environment="HTTP_PROXY=http://user:pass@proxy.example.com:3128/" "HTTPS_PROXY=http://user:pass@proxy.example.com:3128/" "NO_PROXY=localhost,127.0.0.0/8,10.0.0.0/8,192.168.0.0/16,172.16.0.0/12"
EOF

# Add proxy to Containerd
sudo mkdir -p /etc/systemd/system/containerd.service.d
cat <<EOF | sudo tee /etc/systemd/system/containerd.service.d/override.conf
[Service]
Environment="HTTP_PROXY=http://user:pass@proxy.example.com:3128/" "HTTPS_PROXY=http://user:pass@proxy.example.com:3128/" "NO_PROXY=localhost,127.0.0.0/8,10.0.0.0/8,192.168.0.0/16,172.16.0.0/12"
EOF


# Restart Docker
sudo systemctl daemon-reload
sudo systemctl restart docker containerd

#sudo rm /etc/apt/apt.conf.d/21proxy

# Disable swap
sudo swapoff --all
sudo sed -i '/^.*swap.*/ d' /etc/fstab

# Add shecan
#cat <<EOF | sudo tee /etc/netplan/01-netcfg.yaml
## This file describes the network interfaces available on your system
## For more information, see netplan(5).
#network:
#  version: 2
#  renderer: networkd
#  ethernets:
#    enp0s3:
#      dhcp4: yes
#      dhcp4-overrides:
#        use-dns: no
#      nameservers:
#        addresses: [178.22.122.100,185.51.200.2]
#EOF

sudo netplan apply

exit 0
