# Openebs mayastore 시험
## 개요

## 환경
- Worker 노드의 cpu core 4 로 조정
- Worker 노드 디스크 3개 추가
```
$ vagrant halt
$ cat Vagrantfile
  NodeCount = 1

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "worker#{i}" do |workernode|
      workernode.vm.provider "virtualbox" do |v|
        v.name = "worker#{i}"
        v.memory = 2048
        v.cpus = 4
      (0..3).each do |i|
        workernode.vm.disk :disk, size: "5GB", name: "disk-#{i}"
      end        
$ vagrant up
```

## 설치

## 시험


## 참조
- https://github.com/openebs/Mayastor/tree/a9fc77f2ae30e909244556fc797451931dab3dd5/test/e2e/setup
- https://mayastor.gitbook.io/introduction/
- https://docs.openebs.io/docs/next/releases.html
- [vagrant disk config](https://www.vagrantup.com/docs/disks/usage)
