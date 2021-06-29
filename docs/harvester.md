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

## 참고자료
- https://docs.harvesterhci.io/v0.2/
- https://github.com/harvester/harvester/wiki/Setting-Up-Harvester-Development-Environment
- https://www.suse.com/c/meet-harvester-an-hci-solution-for-the-edge-src/
