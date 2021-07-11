# Jetson Nano 2G

## 설치

### SD 카드 이미지 설치 
- 이미지([Jetson Nano 2GB Developer Kit SD Card Image](https://developer.nvidia.com/jetson-nano-2gb-sd-card-image)) 다운로드 및 설치
- SD Card Formatter](https://www.sdcard.org/downloads/formatter/sd-memory-card-formatter-for-windows-download/) 다운로드 및 설치
- [Etcher](https://www.balena.io/etcher/) 다운로드
- SD 카드 넣고 SD Card Formatter 실행한 후 Quick Format 포맷 진행
- balenaEtcher 실행하고 SD 카드에 이미지 설치

### Jetson Nana 부팅
- SD 카드 삽입하고 부팅
- Review and accept NVIDIA Jetson software EULA
- Select system language, keyboard layout, and time zone
- Create username, password, and computer name
- Optionally configure wireless networking
- Select APP partition size. It is recommended to use the max size suggested
- Create a swap file. It is recommended to create a swap file
### GPU 활성화
- config nvida default runtime 
```
$ vi /etc/docker/daemon.json 
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```
- 확인
```
$ sudo docker info | grep Runtime
 Runtimes: nvidia runc
 Default Runtime: nvidia
```

### GPU 테스트
- pull the TensorFlow 2.2 container image for L4T from NGC ([NVIDIA GPU Cloud](https://ngc.nvidia.com/catalog))
```
sudo docker pull nvcr.io/nvidia/l4t-tensorflow:r32.4.3-tf2.2-py3
```
- check if TensorFlow can access the GPU available on Jetson Nano
```
sudo docker run -it --rm --runtime nvidia \ 
--network host \
nvcr.io/nvidia/l4t-tensorflow:r32.4.3-tf2.2-py3 \
python3
> import tensorflow as tf
> print(tf.__version__)
```
### 메인 페이지
- [Jetson Community Projects](https://developer.nvidia.com/embedded/community/jetson-projects)
- [Jetson Zoo](https://elinux.org/Jetson_Zoo)
- [Jetson Developer Zone](https://developer.nvidia.com/embedded-computing)
- [Jetson Support Forums](https://forums.developer.nvidia.com/c/agx-autonomous-machines/jetson-embedded-systems/70)

### Ubuntu 20.04 업데이트
- [ubuntu 20.04 업데이트](https://stackdata.com/upgrade-nvidia-jetson-nano-from-ubuntu-bionic-beaver-to-focal-fossa/)
- [Connect to network before user login](https://askubuntu.com/questions/16376/connect-to-network-before-user-login)
```
# vi /etc/NetworkManager/system-connections/iptime-choi_5G
permissions=  # remove values of permissions
```



## 참고자료
- [Jetson 설치 가이드](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-2gb-devkit)
