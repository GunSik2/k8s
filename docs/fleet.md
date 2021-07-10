
# Rancher Fleet

## Fleet Agent 설치
- Rancher 서버에 K3s 등록 : Global > Add Cluster > Other Cluster > Create
- K3s 실행
```
curl --insecure -sfL https://14.49.44.246:8443/v3/import/x..sdfjslkj.yaml | kubectl apply -f -
```

## Sample 배포 
```
kind: GitRepo
apiVersion: fleet.cattle.io/v1alpha1
metadata:
  name: helm
  namespace: fleet-local
spec:
  repo: https://github.com/GunSik2/fleet-examples
  paths:
  - single-cluster/helm
```

## 참고
- https://cloud.google.com/kubernetes-engine/docs/tutorials/guestbook?hl=ko
- https://github.com/GunSik2/kubernetes-engine-samples/tree/master/guestbook
