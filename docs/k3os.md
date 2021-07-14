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
    inet 192.168.0.48/24 brd 192.168.0.255 scope global wlan0
    
# connmanctl technologies
/net/connman/technology/wifi
  Name = WiFi
  Type = wifi
  Powered = True
  Connected = False
  Tethering = False
```
## eth1 bridge 구성
```
# cat /var/lib/rancher/k3os/config.yaml 
```
- connmanctl
```
# connmanctl services
*AR Wired                ethernet_00e04d69373a_cable
*AR Wired                ethernet_00e04c682126_cable

# connmanctl services  ethernet_00e04d69373a_cable
/net/connman/service/ethernet_00e04d69373a_cable
  Type = ethernet
  Security = [  ]
  State = ready
  Favorite = True
  Immutable = False
  AutoConnect = True
  Name = Wired
  Ethernet = [ Method=auto, Interface=eth1, Address=00:E0:4D:69:37:3A, MTU=1500 ]
  IPv4 = [ Method=dhcp, Address=192.168.0.26, Netmask=255.255.255.0 ]
  IPv4.Configuration = [ Method=dhcp ]
  IPv6 = [  ]
  IPv6.Configuration = [ Method=auto, Privacy=prefered ]
  Nameservers = [ 168.126.63.1, 168.126.63.2 ]
  Nameservers.Configuration = [  ]
  Timeservers = [ ntp.ubuntu.com ]
  Timeservers.Configuration = [  ]
  Domains = [  ]
  Domains.Configuration = [  ]
  Proxy = [  ]
  Proxy.Configuration = [  ]
  mDNS = False
  mDNS.Configuration = False
  Provider = [  ]
```

## Memo
```
# cat /var/lib/rancher/k3os/config.yaml
write_files:
- path: /var/lib/connman/default.config
  content: |-
    [service_eth0]
    Type=ethernet
    IPv4=10.10.10.10/255.255.255.0
    IPv6=off
    MAC=52:54:00:71:ce:88
    [service_eth1]
    Type=ethernet
    IPv4=192.168.108.40/255.255.255.0/192.168.108.1
    IPv6=off
    MAC=52:54:00:9a:cb:6f
    [service_eth2]
    Type=ethernet
    IPv4=10.0.1.10/255.255.255.0
    IPv6=off
    MAC=52:54:00:c7:ad:de
k3os:    
  k3s_args:
    - server
    - "--node-name=k3os-master"
    - "--bind-address=10.10.10.10"
    - "--advertise-address=10.10.10.10"
    - "--flannel-backend=ipsec"
    - "--flannel-iface=eth0"
    - "--node-ip=10.10.10.10"
    - "--node-external-ip=10.0.1.10"    
# k3os cfg --dump    

# cat /var/lib/connman/ethernet_52540071ce88_cable/settings 
[ethernet_52540071ce88_cable]
Name=Wired
AutoConnect=true
Modified=2021-05-19T12:35:23Z
IPv4.method=fixed
IPv4.netmask_prefixlen=24
IPv4.local_address=10.10.10.10
IPv6.method=off
IPv6.privacy=disabled
Config.file=default
Config.ident=service_eth0
```
## Ubuntu bridge 예시
```
# cat /etc/network/interfaces
auto lo
iface lo inet loopback

iface eth0 inet manual
iface eth1 inet manual

# The primary network interface
auto br0
iface br0 inet static
	address 192.168.217.170
	netmask 255.255.255.0
	network 192.168.217.0
	broadcast 192.168.217.255
	gateway 192.168.217.1
	# dns-* options are implemented by the resolvconf package, if installed
	dns-nameservers 192.168.210.106
	dns-search infra.example.com
	bridge_ports eth0 eth1
	bridge_ageing 0
	#bridge_fd 5
	#bridge_maxage 12
	#bridge_stp off
	#bridge_maxwait 0

# service networking restart
# ifconfig
br0       Link encap:Ethernet  HWaddr 00:0c:29:fa:6c:ab  
          inet addr:192.168.217.170  Bcast:192.168.217.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:29ff:fefa:6cab/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:63 errors:0 dropped:0 overruns:0 frame:0
          TX packets:27 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:4108 (4.1 KB)  TX bytes:2934 (2.9 KB)

eth0      Link encap:Ethernet  HWaddr 00:0c:29:fa:6c:ab  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:13638 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1961 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:966399 (966.3 KB)  TX bytes:332007 (332.0 KB)  

# ip addr show
<...>
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP qlen 1000
    link/ether 00:0c:29:fa:6c:ab brd ff:ff:ff:ff:ff:ff
<...>
4: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP 
    link/ether 00:0c:29:fa:6c:ab brd ff:ff:ff:ff:ff:ff
    inet 192.168.217.170/24 brd 192.168.217.255 scope global br0
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fefa:6cab/64 scope link 
       valid_lft forever preferred_lft forever

# brctl show
bridge name	bridge id		STP enabled	interfaces
br0		8000.000c29fa6cab	no		eth0
							eth1

# brctl showmacs br0
port no	mac addr		is local?	ageing timer
  1	00:0c:29:fa:6c:ab	yes		   0.00
  2	00:b3:2c:14:3b:d9	yes		   0.00
```

## 참고자료
- [k3os 설정](https://github.com/rancher/k3os#configuration-reference)
- [k3os Networking Setup](https://betterprogramming.pub/k3s-k3os-kubernetes-docker-containers-installation-setup-cluster-ee9ccfd51a4d)
- [ConnMan](https://www.embeddedcomputing.com/technology/security/network-security/the-connman)
- [Nic1](https://github.com/rancher/k3os/issues/703) [bridge 예시](https://www.sauru.so/blog/troubleshooting-w-linux-bridge/)
