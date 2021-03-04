
# CKA Vagrant 환경 구성

## 개요
- VirutalBox & Vagrant 이용한 Kubernetes 설치 (1 master + 3 worker)
- https://github.com/jeromeza/k8s_cka_vagrant

## 환경
- Git
- VirtualBox
- Vagrant
```
vagrant plugin install vagrant-vbguest
```

## 설치
```
git clone https://github.com/jeromeza/k8s_cka_vagrant.git
cd k8s_cka_vagrant/
vagrant up
```

## master 노드 구성
```
$ vagrant ssh control
$ sudo kubeadm init --apiserver-advertise-address=192.168.4.110
// 네트워크 구성
$ kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```
## worker 노드 구성
```
$ vagrant ssh worker1
$ sudo kubeadm join 192.168.4.110:6443 --token kojccd.mk2rzvzq7vtogibl \
    --discovery-token-ca-cert-hash sha256:8cafb1bd18ef16acc32d69ba37f99e55e2581d211e1f4ab6724c992eca3a485e
```

## 설치 확인
```
$ vagrant ssh control
$ kubectl get nodes
NAME                  STATUS   ROLES                  AGE   VERSION
control.example.com   Ready    control-plane,master   11m   v1.20.4
worker1.example.com   Ready    <none>                 78s   v1.20.4
```

## 참고
- [Vagrantfile](../install/Vagrantfile)
- [setup-docker.sh](../install/setup-docker.sh)
- [setup-kubetools.sh](../install/setup-docker.sh)
