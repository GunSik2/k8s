# K3S 

## 개요
- 경량화한 Kubernetes 
- Production ready, easy to install, half the memory, all in a binary less than 100 MB
- It has minimal to no OS dependencies (just a sane kernel and cgroup mounts needed)
- K3S 패키지에 포함된 기술 :
  * [Containerd](https://containerd.io/) & [runc](https://github.com/opencontainers/runc)
  * [Flannel](https://github.com/coreos/flannel) for CNI
  * [CoreDNS](https://coredns.io/)
  * [Metrics Server](https://github.com/kubernetes-sigs/metrics-server)
  * [Traefik](https://containo.us/traefik/) for ingress
  * [Klipper-lb](https://github.com/k3s-io/klipper-lb) as an embedded service loadbalancer provider
  * [Kube-router](https://www.kube-router.io/) for network policy
  * [Helm-controller](https://github.com/k3s-io/helm-controller) to allow for CRD-driven deployment of helm manifests
  * [Kine](https://github.com/k3s-io/kine) as a datastore shim that allows etcd to be replaced with other databases
  * [Local-path-provisioner](https://github.com/rancher/local-path-provisioner) for provisioning volumes using local storage
  * [Host utilities](https://github.com/k3s-io/k3s-root) such as iptables/nftables, ebtables, ethtool, & socat

## 아키텍처
- Single-server Setup with an Embedded DB
![image](https://user-images.githubusercontent.com/11453229/123926517-e8f42b00-d9c6-11eb-99b2-2629a9418cf8.png)

- High-Availability K3s Server with an External DB
![image](https://user-images.githubusercontent.com/11453229/123926607-ff01eb80-d9c6-11eb-9c61-35a0e53491f1.png)

## Install
- 최신 안정 버전 설치
```
curl -sfL https://get.k3s.io | sh -
```
- 지정 안정 버전 설치
```
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.20.4+k3s1 sh -
```
- Rancher 버전 호환성 체크 
  - Rancher K3S Downstream Clusters > Supported K3S Versions
  - https://rancher.com/support-maintenance-terms/all-supported-versions/rancher-v2.5.7/
- Worker 추가 설치
  - Server 토큰 확인
  ```
  $ sudo cat /var/lib/rancher/k3s/server/node-token
  K103b830abc20ad954152bb1836d7ba0ff12761a2a3f1e0b2b53dbca461fbb045b4::server:9755ec56d0bfe2000145289e55e50987
  ```
  - Agent 노드 실행(Rasberry Pi)
  ```
  curl -sfL https://get.k3s.io |   INSTALL_K3S_VERSION=v1.20.4+k3s1 \
  K3S_URL=https://192.168.0.22:6443 \
  K3S_TOKEN=K103b830abc20ad954152bb1836d7ba0ff12761a2a3f1e0b2b53dbca461fbb045b4::server:9755ec56d0bfe2000145289e55e50987 \
  sh -
  ```
  - Agent 노드 실행(Jetson) 
    - k3s 기본 containerd 대신 docker 사용하도록 설정 (--docker)
  ```
  curl -sfL https://get.k3s.io |   INSTALL_K3S_VERSION=v1.20.4+k3s1 \
  INSTALL_K3S_EXEC="--docker" \
  K3S_URL=https://192.168.0.22:6443 \
  K3S_TOKEN=K103b830abc20ad954152bb1836d7ba0ff12761a2a3f1e0b2b53dbca461fbb045b4::server:9755ec56d0bfe2000145289e55e50987 \
  sh -
  ```
    - Docker container 확인
  ```
  sudo docker ps
  ```
## Cluster Access
```
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get pods --all-namespaces
helm ls --all-namespaces
```
## Upgrades
- Install Script 이용한 업그레이드
```
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=vX.Y.Z-rc1 sh -
```

## Backup and Restore
## Volumes and Storage
## Networking
## Security
## Uninstall
- Server 삭제
```
/usr/local/bin/k3s-uninstall.sh  
```
- Agent 삭제
```
/usr/local/bin/k3s-agent-uninstall.sh
```
## 참고자료
- https://rancher.com/docs/k3s/latest/en/
- https://github.com/k3s-io/k3s/blob/master/README.md
- https://rancher.com/docs/k3s/latest/en/advanced/#configuring-containerd
