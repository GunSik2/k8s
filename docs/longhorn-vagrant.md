
## 준비
- worker node iscsi 드라이버 설치
```
# vagrant ssh worker1
# sudo yum install iscsi-initiator-utils -y
```
- helm3 설치
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```


## 설치
- 
```
git clone https://github.com/longhorn/longhorn; 

kubectl create namespace longhorn-system
helm install longhorn ./longhorn/chart/ --namespace longhorn-system

kubectl -n longhorn-system get svc
NAME                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
longhorn-backend    ClusterIP   10.100.142.127   <none>        9500/TCP   18s
longhorn-frontend   ClusterIP   10.108.225.121   <none>        80/TCP     18s
```
- 설치 확인
```
kubectl get pods --namespace longhorn-system --watch
```

## 삭제
```
helm uninstall longhorn ./longhorn/chart/ --namespace longhorn-system
```

## helm 바로 설치
```
helm repo add longhorn https://charts.longhorn.io
helm repo update
kubectl create namespace longhorn-system
helm install longhorn longhorn/longhorn --namespace longhorn-system
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}' # remove local-path as default provisioner
```
## 참고
- https://longhorn.io/docs/0.8.0/install/requirements/
- https://kubernetes.io/ko/docs/reference/kubectl/cheatsheet/
- https://sj14.gitlab.io/post/2021/01-30-free-k8s-cloud-cluster/
