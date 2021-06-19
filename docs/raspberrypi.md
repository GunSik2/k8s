# Raseberry Pi 와 노트북 연결

## 사용툴
- Raspberry Pi Imager : https://www.raspberrypi.org/software/
- Ubuntu Server 20.04.2 LTS : https://ubuntu.com/download/raspberry-pi
- 네트워크 Scanner : https://www.advanced-ip-scanner.com/

## 설치 절차
### SD 카드 준비
- Raspberry Pi Imager 설치 후 실행
  > SD 카드에 OS 설치
  > OS : Ohter General Purpose OS > Ubuntu 20.04.2 LTS for arm64 
- Wi-Fi 설정
  > SD 카드 마운트 후 파일 설정
  > network-config
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
  > SD 카드 삽입후 부팅
  > 원격 접속 IP 확인
```
arp -a | findstr b8-27-eb   # Raspberry 3 
arp -a | findstr dc-a6-32   # Raspberry 4 
```

## 참고
- 설치절차: https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi
## SD 카트 OS 설치
- 
- https://www.raspberrypi.org/software/
