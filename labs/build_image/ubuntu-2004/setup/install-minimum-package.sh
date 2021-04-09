#!/usr/bin/env sh

# disable translate download and add proxy
cat <<EOF | sudo tee /etc/apt/apt.conf.d/20translate
Acquire::Languages "none";
EOF

sudo apt-get update 
sudo apt-get install -y apt-transport-https curl ca-certificates software-properties-common gnupg2 vim traceroute bash-completion python-minimal
sudo apt-get upgrade -y
sudo apt-get clean
