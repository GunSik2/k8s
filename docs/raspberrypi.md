# Raseberry Pi + Ubuntu 20.04 + K3S

## 사용툴
- Raspberry Pi Imager : https://www.raspberrypi.org/software/
- Ubuntu Server 20.04.2 LTS : https://ubuntu.com/download/raspberry-pi
- 네트워크 Scanner : https://www.advanced-ip-scanner.com/

## 설치 절차
### SD 카드 준비
- Raspberry Pi Imager 설치 후 실행
  - SD 카드에 OS 설치
  - OS : Ohter General Purpose OS > Ubuntu 20.04.2 LTS for arm64 
- Wi-Fi 설정
  - SD 카드 마운트 후 파일 설정
  - network-config
```
wifis:
  wlan0:
    dhcp4: true
    optional: true
    access-points:
      "iptime-choi":
        password: "***"
```
- Raspberry Pi 부팅 
  - SD 카드 삽입후 부팅: 
  - 원격 접속 IP 확인 
```
arp -a | findstr b8-27-eb   # Raspberry 3 
arp -a | findstr dc-a6-32   # Raspberry 4 
```
- Raspberry 접속
```
ssh ubuntu@<ip>  # 기본 password: ubuntu 
```

## K3S 설치
- 설정 변경
```
# vi /boot/firmware/cmdline.txt
cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1  # 라인에 추가

# vi hostname
rpik3s
```
- 재부팅
- k3s 설치
```
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.20.4+k3s1 sh -
```
- 삭제
```
/usr/local/bin/k3s-uninstall.sh
```

## Fleet Agent 설치
- Rancher 서버에 K3s 등록 : Global > Add Cluster > Other Cluster > Create
- K3s 실행
```
curl --insecure -sfL https://14.49.44.246:8443/v3/import/x..sdfjslkj.yaml | kubectl apply -f -
```

## Tool
- kubeconfig
```
mkdir -p $HOME/.kube/k3s 
touch $HOME/.kube/k3s/config
chmod 600 $HOME/.kube/k3s/config

cat /etc/rancher/k3s/k3s.yaml > $HOME/.kube/k3s/config
export KUBECONFIG=$HOME/.kube/k3s/config
```
- k9s
```
snap install k9s
k9s
```

## 참고
- 설치절차: https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi
- Wireguard+k3s: https://www.inovex.de/de/blog/how-to-set-up-a-k3s-cluster-on-wireguard/