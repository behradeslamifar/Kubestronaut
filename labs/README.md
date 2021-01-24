# Certified Kubernetes Administrator (CKA)

## Install and Preparation

### Install Packer
Download packer file and copy to bin folder
```
wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip
unzip packer_1.6.0_linux_amd64.zip
mv packer /usr/local/bin/
```

### Install Vagrant
1. Browse [vagrant download page](https://www.vagrantup.com/downloads)
2. Download vagrant for linux
3. Unzip downloaded file
```
unzip vagrant_2.2.10_linux_amd64.zip
```
4. Move excutable file to /usr/local/bin
```
mv vagrant /usr/local/bin
```
5. Examine correct installation
```
$ vagrant --version
Vagrant 2.2.10
```

### Build Base Images
1. Build Ubuntu base image
  * [Build Ubuntu 18.04](build_image/ubuntu-1804/)
  * [Build Ubuntu 20.04](build_image/ubuntu-2004/) - Not ready yet

2. [Build Kubernetes image](build_image/k8s/)
3. Storage  
If you want remote disk in your test cluster [build Ceph image](build_image/ceph/) too.

### Add Vagrant box to local vagrant
```
vagrant box add --name ubuntu-1804 labs/build_image/ubuntu-1804/packer_virtualbox-iso_virtualbox.box
vagrant box add --name k8s-ubuntu-1804 labs/build_image/k8s/packer_virtualbox-iso_virtualbox.box
vagrant box add --name ceph-ubuntu-1804 labs/build_image/ceph/packer_virtualbox-iso_virtualbox.box
```

### Run Vagrant
