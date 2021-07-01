# K3os 


## wifi 활성화
### 호스트명 및 네트워크 설정
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
### 네트워크 설정
- wifi 미활성 상태 확인
```
# ip a | grep wlan0
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
# connmanctl technologies
/net/connman/technology/wifi
  Name = WiFi
  Type = wifi
  Powered = True
  Connected = False
  Tethering = False
```
- wifi 활성화
```
# connmanctl services   # list of all available networks
*AR Wired                ethernet_00e04c682126_cable
*A  Crossent_5G          wifi_548ca074776b_43726f7373656e745f3547_managed_psk

# connmanctl connect wifi_548ca074776b_43726f7373656e745f3547_managed_psk
```
- wifi 활성 상태 확인
```
# ip a | grep wlan0
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000

# connmanctl technologies
/net/connman/technology/wifi
  Name = WiFi
  Type = wifi
  Powered = True
  Connected = False
  Tethering = False
```

## 참고자료
- [k3os 설정](https://github.com/rancher/k3os#configuration-reference)
- [k3os Networking Setup](https://betterprogramming.pub/k3s-k3os-kubernetes-docker-containers-installation-setup-cluster-ee9ccfd51a4d)
- [ConnMan](https://www.embeddedcomputing.com/technology/security/network-security/the-connman)
