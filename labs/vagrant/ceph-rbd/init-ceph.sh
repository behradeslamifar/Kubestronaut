#!/bin/bash

IP=$1

echo 'export PS1="\e[0;31m[\u@\h:\w\a]$ \e[m"' | sudo tee -a /root/.bashrc
sudo sed -i '/ceph-mon-01/ d' /etc/hosts
echo "$IP    ceph-mon-01" | sudo tee -a /etc/hosts

cat <<EOF >ceph.conf
[global]
osd crush chooseleaf type = 0
EOF

cephadm bootstrap \
  --mon-ip $IP \
  --initial-dashboard-user admin \
  --initial-dashboard-password password \
  --skip-pull \
  --config ceph.conf

ceph orch daemon add osd ceph-mon-01:/dev/sdb
ceph orch daemon add osd ceph-mon-01:/dev/sdc
ceph orch daemon add osd ceph-mon-01:/dev/sdd

ceph osd pool create cka 32

exit 0
