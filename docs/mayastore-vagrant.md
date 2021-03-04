# Openebs mayastore 시험
## 개요
- vagrant k8s 환경에 다음 사항을 추가
- Worker 노드의 cpu core 4 로 조정
- Worker 노드 디스크 3개 추가

## 환경
- Vagrant version 2.2.14 (disk 추가를 위해 v2.2.6 이상 필요) 

## 설치
- Vagrant 설정 변경 및 적용
```
$ vagrant halt
$ cat Vagrantfile
Vagrant.require_version ">= 2.2.6"
ENV['VAGRANT_NO_PARALLEL'] = 'yes'
ENV['VAGRANT_EXPERIMENTAL'] = 'disks'
..
  NodeCount = 1

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "worker#{i}" do |workernode|
      workernode.vm.provider "virtualbox" do |v|
        v.name = "worker#{i}"
        v.memory = 2048
        v.cpus = 4
      (0..1).each do |i|    # Root 포함 최대 4개 디스크 가능 
        workernode.vm.disk :disk, size: "5GB", name: "disk-#{i}"
      end        
$ vagrant up
```

## 시험


## 참조
- https://github.com/openebs/Mayastor/tree/a9fc77f2ae30e909244556fc797451931dab3dd5/test/e2e/setup
- https://mayastor.gitbook.io/introduction/
- https://docs.openebs.io/docs/next/releases.html
- [vagrant disk config](https://www.vagrantup.com/docs/disks/usage)
