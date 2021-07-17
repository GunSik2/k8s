# Jetson Nano 2G

## 설치

### SD 카드 이미지 설치 
- 이미지([Jetson Nano 2GB Developer Kit SD Card Image](https://developer.nvidia.com/jetson-nano-2gb-jp441-sd-card-image)) 다운로드 및 설치
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
- kubernetes 설치된 경우
```
$ sudo kubectl run -it nvidia --image=jitteam/devicequery --restart=Never
./deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "NVIDIA Tegra X1"
  CUDA Driver Version / Runtime Version          10.2 / 10.0
  CUDA Capability Major/Minor version number:    5.3
  Total amount of global memory:                 1980 MBytes (2076037120 bytes)
  ( 1) Multiprocessors, (128) CUDA Cores/MP:     128 CUDA Cores
  GPU Max Clock rate:                            922 MHz (0.92 GHz)
  Memory Clock rate:                             13 Mhz
  Memory Bus Width:                              64-bit
  L2 Cache Size:                                 262144 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(65536), 2D=(65536, 65536), 3D=(4096, 4096, 4096)
  Maximum Layered 1D Texture Size, (num) layers  1D=(16384), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(16384, 16384), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 32768
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 1 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            Yes
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            No
  Supports Cooperative Kernel Launch:            No
  Supports MultiDevice Co-op Kernel Launch:      No
  Device PCI Domain ID / Bus ID / location ID:   0 / 0 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.2, CUDA Runtime Version = 10.0, NumDevs = 1
Result = PASS
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

### 트러블슈팅
- [Load jetson 4.5 error](https://forums.developer.nvidia.com/t/full-wipe-load-jetpack-4-5-errors/166629)
  -  JetPack4.4.1 이미지 사용하여 진행 필요
```
# ./docker_dli_run.sh 
docker: Error response from daemon: OCI runtime create failed: container_linux.go:349: starting container process caused "process_linux.go:449: container init caused \"process_linux.go:432: running prestart hook 0 caused \\\"error running hook: exit status 1, stdout: , stderr: exec command: [/usr/bin/nvidia-container-cli --load-kmods configure --ldconfig=@/sbin/ldconfig.real --device=all --compute --compat32 --graphics --utility --video --display --pid=27601 /var/lib/docker/overlay2/00eb3e443a711b4a767f70a19fa1fb7310910f991c86459af83b98d8f6e5444f/merged]\\\\nnvidia-container-cli: mount error: file creation failed: /var/lib/docker/overlay2/00eb3e443a711b4a767f70a19fa1fb7310910f991c86459af83b98d8f6e5444f/merged/usr/lib/aarch64-linux-gnu/libnvidia-fatbinaryloader.so.440.18: file exists\\\\n\\\"\"": unknown.
```

## 참고자료
- [Jetson 설치 가이드](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-2gb-devkit)
- [Jetson AI Certification](https://developer.nvidia.com/embedded/learn/jetson-ai-certification-programs)
- [Running k3s, Ligthweigth Kubernetes on NV Jetson cluster](https://www.hackster.io/WhoseAI/running-k3s-lightweight-kubernetes-on-nv-jetson-cluster-93e577)
