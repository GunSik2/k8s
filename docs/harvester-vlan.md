# Harvester vlan 구성 리서치

## Management 네트워크 사용 상태
- vlan Disable 상태 (Settings > vlan > Disable)
- interface

  ![image](https://user-images.githubusercontent.com/11453229/124583094-9ff01b00-de8d-11eb-8e11-1e54ba3a6ad3.png)
  ![image](https://user-images.githubusercontent.com/11453229/124582904-6f0fe600-de8d-11eb-9975-91447b49e90c.png)

- 네트워크 생성
  ![image](https://user-images.githubusercontent.com/11453229/124583350-e9d90100-de8d-11eb-83e0-dd218e0b39ce.png)


## VLAN 구성 (management 단일 구성 시)
- Settings > vlan > eth0
  ![image](https://user-images.githubusercontent.com/11453229/124581233-df1d6c80-de8b-11eb-8949-63d0dbee478d.png)

- Hosts > network > vlan - eth0 미활성화
  ![image](https://user-images.githubusercontent.com/11453229/124581295-ef354c00-de8b-11eb-8a92-bec7e2549dcc.png)

### 가상서버 생성 (management Network / masqreade)  
  ![image](https://user-images.githubusercontent.com/11453229/124581404-0c6a1a80-de8c-11eb-9270-8d6de720464d.png)
  ![image](https://user-images.githubusercontent.com/11453229/124583633-3cb2b880-de8e-11eb-8cd0-0ba337d5af87.png)
  ![image](https://user-images.githubusercontent.com/11453229/124583597-2e649c80-de8e-11eb-863b-f865fcdfcf59.png)


## VLAN 구성 (vlan 구성 시)
- Settings > vlan > eth1
  ![image](https://user-images.githubusercontent.com/11453229/124583961-a3d06d00-de8e-11eb-858b-eeffe5d4b740.png)
  ![image](https://user-images.githubusercontent.com/11453229/124584021-bb0f5a80-de8e-11eb-9111-ab0387d2f599.png)

- Hosts > network > vlan - eth1 확인
  ![image](https://user-images.githubusercontent.com/11453229/124584171-e42feb00-de8e-11eb-91ef-10d278c331b0.png)

### 가상서버 생성 (management Network / bridge) 
  ![image](https://user-images.githubusercontent.com/11453229/124584570-5f919c80-de8f-11eb-97ca-642369250309.png)
  ![image](https://user-images.githubusercontent.com/11453229/124585935-c6638580-de90-11eb-8aee-80364f35edf1.png)
  ![image](https://user-images.githubusercontent.com/11453229/124584821-a41d3800-de8f-11eb-9aab-622d9f9a5837.png)
  ![image](https://user-images.githubusercontent.com/11453229/124584857-aed7cd00-de8f-11eb-89f3-0439b2b3a22c.png)

- vlan 네트워크 생성
  ![image](https://user-images.githubusercontent.com/11453229/124585111-f2cad200-de8f-11eb-8fb4-bc6c1ee55bbb.png) 

### 가상서버 생성 (host-network / bridge) : vlan 스위치 미구성 상태
  ![image](https://user-images.githubusercontent.com/11453229/124585317-1ee65300-de90-11eb-8a7e-ddce68727e40.png)
  ![image](https://user-images.githubusercontent.com/11453229/124585656-77b5eb80-de90-11eb-9780-fc464546038e.png)
  ![image](https://user-images.githubusercontent.com/11453229/124585450-43dac600-de90-11eb-8a5b-3c7b17c36072.png)
  ![image](https://user-images.githubusercontent.com/11453229/124585542-59e88680-de90-11eb-9ce2-299789eb081b.png)

### 가상서버 생성 (management Network / masqreade + host-network / bridge) : vlan 스위치 미구성 상태
![image](https://user-images.githubusercontent.com/11453229/124587030-227ad980-de92-11eb-9387-ab0727189da3.png)
![image](https://user-images.githubusercontent.com/11453229/124587099-36bed680-de92-11eb-9bc9-02f16706da63.png)
![image](https://user-images.githubusercontent.com/11453229/124587320-74bbfa80-de92-11eb-8d87-f480f73d7847.png)
![image](https://user-images.githubusercontent.com/11453229/124587346-7be30880-de92-11eb-8102-56743f3ccff0.png)




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
