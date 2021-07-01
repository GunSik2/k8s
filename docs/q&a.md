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
- [Harvester Network](https://docs.harvesterhci.io/v0.2/harvester-network/)

### 네트워크
- Harvester 는 management network 와 VLAN 을 지원
- 관리 네트워크는 flannel 이용하여 구현(masquerade 모드로 동작)되었고, 내부 네트워크로 VM 관리망은 클러스터 노드나 Pod 내에서 접근 가능
- VLAN 네트워크는 multus와 bridge CNI 플러그인을 이용하여 VLAN을 구현함
![image](https://user-images.githubusercontent.com/11453229/124059827-b732a100-da66-11eb-9f0c-36f216c1451f.png)
  - Harvester 네트워크 컨트롤러는 노드 브리지와 veth 패어를 이용하여 VLAN을 구현
  - Bridge 는 VMS와 스위치간 포트 연결된 스위치처럼 동작하여, VM과 veth 패어간 트래픽을을 전달 
  - 호스트와 연결된 외부 스위치 포트는 트렁크나 하이브리드 타입으로 설정되어, 지정한 VLANs을 허용함
  - 사용자는 PVID (기본값 1) VLAN 이용하여 테그가 붙지 않은 트래픽과 통신 가능   
- Harvester 클러스터 외부에서 바로 접끈 가능하려면 NodePort 서비스나 LoadBalancer 서비스 생성 필요



### Rancher 활성화 
- Harveseter > Settings > Enalbe Rancher 활성화 후 Harvester 오른쪽 상단 Rancher 메뉴 이동
### Harvester Driver 이용한 K8S 배포
- Rancher > Add Cluster > Harvester 에서 등록

### Rancher 
## K3S
- traffik & klipper-lb 구조

