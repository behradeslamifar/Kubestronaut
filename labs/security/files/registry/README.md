# Private Docker Registry

## Install Docker-compose
Install on server  
```
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose
apt-get install -y apache-utils
```

## Prepare environment
```
mkdir -p registry/{auth,certs,data,conf}
```

Create certificate  
```
# openssl req -x509 -new -days 365 -nodes -out certs/domain.crt -keyout certs/domain.key -subj '/CN=registry.example.com/'
Generating a RSA private key
.......+++++
...........+++++
writing new private key to 'certs/domain.key'
-----
```

Create user and password file  
```
# htpasswd -Bc auth/htpasswd behrad
New password:
Re-type new password:
Adding password for user behrad
```

```
# echo “192.168.43.202
registry.example.com” >> /etc/hosts
```

```
k8s-node ~:# vi /etc/docker/daemon.json
{
...
"insecure-registries":["registry.example.com:5000"]
}
k8s-node ~:# systemctl restart docker
```
