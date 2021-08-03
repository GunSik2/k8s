
# Harvester

## 설치환경
- 노트북 i7, 16G Mem

## Longhorn expose
```
kubectl expose deployment longhorn-ui --namespace=longhorn-system --type=NodePort --name=longhorn-ui
kubectl describe service longhorn-ui --namespace=longhorn-system
```
## 참고자료
- https://blog.linnovate.net/baremetal-kubernetes-with-harvester-and-k3s-25fe9e7ab695
