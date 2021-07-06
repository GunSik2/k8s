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
password: password
chpasswd: { expire: False}
ssh_pwauth: True
packages:
  - qemu-guest-agent
```
- Network setting
```
version: 1
config:
  - type: physical
    name: enp1s0 
    subnets:
      - type: dhcp
  - type: physical
    name: enp2s0 
    subnets:
      - type: DHCP
```

## 참고
- https://docs.harvesterhci.io/v0.2/harvester-network/
- https://benisnous.com/lets-learn-harvester/
