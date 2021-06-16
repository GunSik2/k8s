
# Rancher Fleet


## 배포 
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
