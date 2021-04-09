# Build Image with Packer

## Requirements 
1. Install packer
Download packer file and copy to bin folder  
```
wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip
unzip packer_1.6.0_linux_amd64.zip
mv packer /usr/local/bin/
```

2. Download Ubuntu server 18.04 image (legacy installer)
You can find latest version from [Ubuntu.com](http://cdimage.ubuntu.com/releases/18.04/release/). 

3. Downlaod  VirtualBox GuestAdditions iso
Find proper version at [VirtualBox Website](http://download.virtualbox.org/virtualbox/6.1.18/VBoxGuestAdditions_6.1.18.iso)


## Configuration
Change these parameters based on your environment
```
...
    "iso_path": "/home/behrad/Downloads/ISO/ubuntu-20.04.1-live-server-amd64.iso",
    "iso_hash": "md5:a3e1c494a02abf1249749fa4fd386438",
    "build": "200820"
...
      "guest_additions_url": "/home/behrad/Downloads/ISO/VBoxGuestAdditions.iso",
      "guest_additions_sha256": "78fa2ba78e91c7d6f16f8c7fa88676cc9772c7689ba47e2b19913670fad2d441",
...
```
 
## Build ova image for virtulabox
Just run  
```
packer build template.json
```
