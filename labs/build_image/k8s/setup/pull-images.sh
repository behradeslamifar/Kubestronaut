#!/usr/bin/env sh

KUBE_VERSION=1.20.5

# Pull kubernetes images
sudo kubeadm --kubernetes-version $KUBE_VERSION config images pull

# Pull Calico images
sudo docker pull calico/cni:v3.18.1
sudo docker pull calico/pod2daemon-flexvol:v3.18.1
sudo docker pull calico/node:v3.18.1
sudo docker pull docker.io/calico/kube-controllers:v3.18.1

# Remove proxy
#sudo rm /etc/systemd/system/docker.service.d/override.conf
sudo systemctl daemon-reload
sudo systemctl restart docker

exit 0
