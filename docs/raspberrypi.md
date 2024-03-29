# Raseberry Pi + Ubuntu 20.04 

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
  - /boot/firmware/network-config
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

## 초기 환경 구성
- Host명 변경
```
# vi hostname
rpik3s
```
- Memory cgroup 활성화 : K3S 설치 사전 필수
```
# vi /boot/firmware/cmdline.txt
cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1  # 라인끝에 내용 추가
```

## 참고
- 설치절차: https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi
- Wireguard+k3s: https://www.inovex.de/de/blog/how-to-set-up-a-k3s-cluster-on-wireguard/
