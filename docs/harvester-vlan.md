# Harvester vlan 구성 리서치

## VLAN 구성 
```
sudo modprobe 8021q

ip link add link eth0 name eth0.100 type vlan id 100
sudo ip addr add 10.0.0.1/24 dev eth1.100
```
## Bridge 구성
```
brctl addbr br1
brctl addif br1 eth1
ip link set dev eth1 up
```
## Cloud-init 구성
- Password Seeting
```
#cloud-config
password: password
chpasswd: { expire: False}
ssh_pwauth: True
packages:
  - qemu-guest-agent
```
- Network setting
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
	address: 10.0.0.10
```
