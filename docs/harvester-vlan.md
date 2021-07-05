# Harvester vlan 구성 리서치

## VLAN 구성 
```
sudo modprobe 8021q

ip link add link eth0 name eth0.100 type vlan id 100
sudo ip addr add 10.0.0.1/24 dev eth1.100
```

## Cloud-init 구성
```
version: 2
renderer: networkd
ethernets:
  enp1s0:
    dhcp4: true
  enp2s0:
    dhcp4: false
vlans:
  enp2s0.100:
    id: 100
    link: enp2s0
	address: 10.0.0.2
```
