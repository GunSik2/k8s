# Bridge 구성 사례


## 매뉴얼 구성
- eth0 - br0 - wifi 
```
#!/bin/sh
#WiFi bridge ohne NAT

#create bridge interface br0
ip link add name br0 type bridge
ip link set br0 up

#assign eth0 to br0, eth0 must be up
ip link set eth0 up
ip link set eth0 master br0

#save eth0 ip-address and gw
eth_ip=`ip addr show eth0 | awk '/inet / {printf("%s", $2)}'`
eth_gw=`route -n | awk '/^0.0.0.0/ {printf("%s", $2)}'`

#move from eth0 to br0
ip addr del $eth_ip dev eth0
ip addr add $eth_ip broadcast + dev br0
route add -net default gw $eth_gw

#assign wlan0 to br0
ip link set wlan0 master br0
```
## ubuntu 설정 구성
```
$ sudo apt-get install bridge-utils

$ cat /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
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

$ sudo service networking restart

 ip addr show
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
       
$ brctl show
bridge name	bridge id		STP enabled	interfaces
br0		8000.000c29fa6cab	no		eth0
							                eth1
                              
$ brctl showmacs br0
port no	mac addr		is local?	ageing timer
  1	00:0c:29:fa:6c:ab	yes		   0.00
  2	00:b3:2c:14:3b:d9	yes		   0.00              
```

## 참고자료
- https://www.sauru.so/blog/troubleshooting-w-linux-bridge/
- https://www.hanewin.net/rpi/bridge.htm
