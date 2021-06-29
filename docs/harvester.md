# Harvester

## 설치 (VirtualBox 환경)

Download and install the Virtualbox 6.x, click to create a new VM with the following configuration:
- choose Type: Linux and Version: Other Linux(64-bit)
- set memory size to a minimum of 8192MB
- set disk size to a minimum of 200GB
- clicking the Settings of the created VM and navigate to the System > Processor to set the CPU to a minimum of 4 cores, 
  and enable the PAE/NX option, and set the nested virtualization via terminal with:
 - VBoxManage modifyvm "$custom-name" --nested-hw-virt on
 - go to the networks panel and enable the second network adaptor with either attached to the Host-only Adaptor or any other type of adaptor 
   that can be accessed from your local network later.
- lastly, follow the ISO installation and install the Harvester to your VM.
- optionally you can create more VMs to form a cluster.

## 테스트 
### 이미지 등록 
- URL: https://uec-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img
![image](https://user-images.githubusercontent.com/11453229/123719741-44d28d00-d8bd-11eb-8220-a2223a856751.png)

### 가상서버 생성
![image](https://user-images.githubusercontent.com/11453229/123720464-2077b000-d8bf-11eb-86f5-a112da5ac519.png)
- VirtualBox 6.1 업그레이드 후 해결. VirtualBox 6.1 부터 Intel Chip에 대한 중첩 가상화 지원 (6.0은 AMD 만 지원)
- 정상 배포 사례
![image](https://user-images.githubusercontent.com/11453229/123727788-2aa0ab00-d8cd-11eb-8867-bb4e868bd61b.png)
- 시리얼 통신 및 콘솔 지원
![image](https://user-images.githubusercontent.com/11453229/123728126-c3372b00-d8cd-11eb-8b45-63f12abb7409.png)


## 참고자료
- https://docs.harvesterhci.io/v0.2/
- https://github.com/harvester/harvester/wiki/Setting-Up-Harvester-Development-Environment
- https://www.suse.com/c/meet-harvester-an-hci-solution-for-the-edge-src/
- https://docs.harvesterhci.io/v0.2/rancher/node-driver/
- [Kubevirt windows migration](https://kubevirt.io/2020/win_workload_in_k8s.html)
- [Nested Virtualization in VirtualBox](https://ostechnix.com/how-to-enable-nested-virtualization-in-virtualbox/)
