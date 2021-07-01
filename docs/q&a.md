# Q&A

## K3OS
### K3OS apk 사용
From the README.md (emphasis mine):

> k3OS is a Linux distribution designed to remove as much as possible OS maintenance in a Kubernetes cluster. 
> It is specifically designed to only have what is need to run k3s. Additionally the OS is designed to be managed by kubectl once a cluster is bootstrapped. 
> Nodes only need to join a cluster and then all aspects of the OS can be managed from Kubernetes. Both k3OS and k3s upgrades are handled by the k3OS operator.

Software installation via Alpine's apk is not supported.

## Harvester
- [Harvester VM with Bridged Network](https://www.belgai.de/blog/harvester/harvester_bridge_network/)
- [Harvester Beta Features](https://community.suse.com/posts/announcing-harvester-beta-availability)
- [Rancher Harvester Node Driver](https://docs.harvesterhci.io/v0.2/rancher/node-driver/)

### Rancher 활성화 
- Harveseter > Settings > Enalbe Rancher 활성화 후 Harvester 오른쪽 상단 Rancher 메뉴 이동
### Harvester Driver 이용한 K8S 배포
- Rancher > Add Cluster > Harvester 에서 등록

### Rancher 
## K3S
- traffik & klipper-lb 구조


