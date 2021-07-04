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
- 코드 테스트 (blink.py)
```
from gpiozero import LED
from signal import pause

red = LED(17)

red.blink()

pause()
```

## PI Deployment 배포
- Dockerfile
```
FROM python:3

ADD blink.py /

RUN pip install gpiozero

CMD [ "python3" , "./blink.py" ]
```
- Build
```
docker buildx build --push --platform linux/amd64,linux/arm64 -t cgshome2/rpi-led-blink .
```
- Deploy
```
$ cat blink.yml
---
apiVersion: v1
kind: Pod
metadata:
  name: rpi-led-blink
spec:
  containers:
    - name: rpi-led-blink
      image: cgshome2/rpi-led-blink 
      securityContext:
        privileged: true
  nodeSelector:
    kubernetes.io/arch: arm64
---

$ kubectl apply -f blnik.yml
```


## 에러 조치
### standard_init_linux.go:219: exec user process caused: exec format error 
- Docker 빌드시 arm64 기반 빌드 필요. buildx 이용한 멀티 플랫폼 빌드 지원 필요
- Docker 20 이상에 buildx 기본 설치됨 (참고 [vagrant 환경](https://github.com/GunSik2/k8s/blob/main/install/Vagrantfile-ubuntu20.04))
- 멀티 플랫폼 환경 활성화
```
docker run --privileged --rm tonistiigi/binfmt --install arm64  # emulator 1회 설치 필요
docker buildx create --use
```
- 멀티 플랫폼 환경 빌드
```
docker buildx build --push --platform linux/amd64,linux/arm64 -t cgshome2/rpi-led-blink .
```
### Github Action 이용한 멀티 플랫폼 자동 빌드
- Docker Hub 자동 Push 위한 Access Token 생성
  - Docker Hub > Account Settings > Security > New Access Token 
- Github Action 변수 등록 
  - Github > Repository > Settings > Secrets > New repository secret
  - DOCKER_USERNAME (docker hub username), DOCKER_PASSWORD (복사한 access token) 
- Action 등록 (.github/workflows/rpi-led-blink.yaml)
```
name: cgshome2/rpi-led-blink

on:
  push:
    branches: 
    - main
  pull_request:
    branches:
    - main

jobs:         
  build:
    runs-on: ubuntu-latest
    steps:
      - name: checkout 
        uses: actions/checkout@v2
        
      - name: login to docker hub
        uses: docker/login-action@v1
        with: 
          username: "${{ secrets.DOCKER_USERNAME }}"
          password: "${{ secrets.DOCKER_PASSWORD }}"

      - name: Set up QEMU
        uses: docker/setup-qemu-action@v1
        
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1

      - name: Inspect builder
        run: |
          echo Platforms: ${{ steps.buildx.outputs.platforms }}
      - name: Build and push
        id: docker_build
        uses: docker/build-push-action@v2
        with:
          context: ./src/rpi/led
          push: true
          tags: cgshome2/rpi-led-blink:latest
          platforms: linux/amd64,linux/arm/v7,linux/arm64
```

## 참고
- https://ubuntu.com/tutorials/gpio-on-raspberry-pi#2-installing-gpio
- https://gpiozero.readthedocs.io/en/stable/recipes.html#led
- https://www.slideshare.net/ssuserc5886a/running-k3s-on-raspberry-pi
- [Multi-arch build and images, the simple way](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/)
- [error in python3.x pip install via qemu for arm64](https://github.com/docker/buildx/issues/493)
