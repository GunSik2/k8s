# Rasberry Pi with Ubuntu GPIO + K3s

## 사전작업
Prepare [raseberrypi](raspberrypi.md)

## GPIO 설치
```
sudo apt install python3-gpiozero
sudo reboot
```
## LED 예제
- GPIO 연결 : 
  - LED 짧은 라인 GROUND 연결
  - LBE 긴 라인 저항 연결 및 GPIO17 연결
- 코드 테스트
```
from gpiozero import LED
from signal import pause

red = LED(17)

red.blink()

pause()
```

## PI Deployment 배포
## 에러 조치
## standard_init_linux.go:219: exec user process caused: exec format error 
- Docker 빌드시 arm64 기반 빌드 필요. buildx 이용한 멀티 플랫폼 빌드 지원 필요
- Docker 20 이상에 buildx 기본 설치됨 (참고 [vagrant 환경](https://github.com/GunSik2/k8s/blob/main/install/Vagrantfile-ubuntu20.04)
- 멀티 플랫폼 빌드 실행
```
docker buildx create --use
docker buildx build --push --platform linux/amd64,linux/arm64 -t cgshome2/rpi-led-blink .
```
- 04 Docker 1.9 이상 환경, amd64 Linux 환경 가정



## 참고
- https://ubuntu.com/tutorials/gpio-on-raspberry-pi#2-installing-gpio
- https://gpiozero.readthedocs.io/en/stable/recipes.html#led
- https://www.slideshare.net/ssuserc5886a/running-k3s-on-raspberry-pi
- [Multi-arch build and images, the simple way](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/)
