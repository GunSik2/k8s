
# CKA Vagrant 환경 구성

## 개요
- VirutalBox & Vagrant 이용한 Kubernetes 설치 (1 master + 3 worker)
- https://github.com/jeromeza/k8s_cka_vagrant

## 환경
- Vagrant
- Git
- VirtualBox


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
- Vagrantfile
```
ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  # Kubernetes Master Server
  config.vm.define "control" do |control|
    control.vm.box = "centos/7"
    control.vm.hostname = "control.example.com"
    control.vm.network "private_network", ip: "192.168.4.110"
    control.vm.provider "virtualbox" do |v|
      v.name = "control"
      v.memory = 2048
      v.cpus = 2
    end
    control.vm.provision "shell", path: "prereqs.sh"
    control.vm.provision "shell", path: "https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-docker.sh"
    control.vm.provision "shell", path: "https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-kubetools.sh"
  end

  NodeCount = 3

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "worker#{i}" do |workernode|
      workernode.vm.box = "centos/7"
      workernode.vm.hostname = "worker#{i}.example.com"
      workernode.vm.network "private_network", ip: "192.168.4.11#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "worker#{i}"
        v.memory = 1024
        v.cpus = 1
      end
      workernode.vm.provision "shell", path: "prereqs.sh"
      workernode.vm.provision "shell", path: "https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-docker.sh"
      workernode.vm.provision "shell", path: "https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-kubetools.sh"
    end
  end

end
```
