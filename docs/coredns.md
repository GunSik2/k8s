# K8S + CoreNDS 사용

## CoreDNS 설정
- Custom 설정
```
# cat dns.yml
apiVersion: v1
kind: ConfigMap
metadata:  
  name: coredns-custom  
  namespace: kube-system 
data:
  example.db: |
    ; example.org test file
    example.org.            IN      SOA     sns.dns.icann.org. noc.dns.icann.org. 2015082541 7200 3600 1209600 3600
    example.org.            IN      NS      b.iana-servers.net.
    example.org.            IN      NS      a.iana-servers.net.
    example.org.            IN      A       127.0.0.1
    a.b.c.w.example.org.    IN      TXT     "Not a wildcard"
    cname.example.org.      IN      CNAME   www.example.net.

    service.example.org.    IN      SRV     8080 10 10 example.org.

# kubectl apply -f dns.yml
```
- 적용 (삭제)
```
kubectl  delete pod --namespace kube-system -l k8s-app=kube-dns
```
- 로그 확인
```
kubectl logs --namespace=kube-system -l k8s-app=kube-dns
kubectl get endpoints -A | grep core
```
- 설정 추가
```
kubectl -n kube-system edit configmap coredns-custom
```

## CoreDNS 테스트
- 테스트
```
kubectl run -it --rm --restart=Never --image=gcr.io/kubernetes-e2e-test-images/dnsutils:1.3 bash
# host example.org
```

## CoreDNS 서비스 노출
- 엔드포인트 확인
```
kubectl get endpoints kube-dns --namespace=kube-system
kubectl get endpoints -l k8s-app=kube-dns --namespace=kube-system
```

## 참고자료
- https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
- https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengconfiguringdnsserver.htm
- https://coredns.io/2017/05/08/custom-dns-entries-for-kubernetes/
