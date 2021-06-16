# K3S 

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
```
curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -
```

## 참고자료
- https://rancher.com/docs/k3s/latest/en/quick-start/
