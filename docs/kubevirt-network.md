# Kubevirt network 이해

## Skydive Tool 설치/활용
- Skydive 설치
```
wget https://github.com/skydive-project/skydive/archive/refs/heads/master.zip
unizp master.zip
cd master/contrib/charts/
helm install skydive-analyzer skydive-analyzer
helm install skydive-agent skydive-agent
kubectl port-forward --address 0.0.0.0 service/skydive-analyzer 8082:8082
```
## 참고자료
- https://berry-sweet.tistory.com/11
- https://kubevirt.io/2018/KubeVirt-Network-Deep-Dive.html
