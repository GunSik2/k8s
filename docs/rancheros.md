
# RancherOS

## Install in Virtualbox
```
git clone https://github.com/rancher/os-vagrant.git
cd os-vagrant

vagrant up
vagrant ssh
```
## Commands
```
sudo system-docker ps
```
## Install Utilities
- curl
```
echo 'docker run --rm radial/busyboxplus:curl curl $@' > /usr/bin/curl && chmod +x /usr/bin/curl
```



## Reference
- https://github.com/rancher/os
- https://qiita.com/ishida330/items/dfff18362ea16aa92f88
