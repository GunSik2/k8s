
# RancherOS

## Install in Virtualbox
```
git clone https://github.com/rancher/os-vagrant.git
cd os-vagrant

vagrant up
vagrant ssh
```

## Install Utilities
- curl
```
echo 'docker run --rm radial/busyboxplus:curl curl $@' > /usr/bin/curl && chmod +x /usr/bin/curl
```
