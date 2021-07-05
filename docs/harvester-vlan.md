# Harvester vlan 구성 리서치

## VLAN 구성 
```
sudo modprobe 8021q

ip link add link eth0 name eth0.100 type vlan id 100
sudo ip addr add 10.0.0.1/24 dev eth1.100
```
