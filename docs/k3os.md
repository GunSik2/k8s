# K3os 


## wifi 활성화
- 호스트명 및 네트워크 설정
```
# cp /k3os/system/config.yaml /var/lib/rancher/k3os/config.yaml
# cat /var/lib/rancher/k3os/config.yaml 
hostname: vmops
k3os:
  k3sArgs:
  ..
  - eth0
  - wlan0
  ...
  wifi:
  - name: Crossent_5G
    passphrase: crossent
# k3os config
# k3os config --dump
```
- 네트워크 설정
```
connmanctl services   # list of all available networks
connmanctl technologies
service conman restart #  Restarts ConnMan to make your changes effective

```
## 참고자료
- [k3os 설정](https://github.com/rancher/k3os#configuration-reference)
- [k3os Networking Setup](https://betterprogramming.pub/k3s-k3os-kubernetes-docker-containers-installation-setup-cluster-ee9ccfd51a4d)
- [ConnMan](https://www.embeddedcomputing.com/technology/security/network-security/the-connman)
