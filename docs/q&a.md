# Q&A

## K3OS
### K3OS apk 사용
From the README.md (emphasis mine):

> k3OS is a Linux distribution designed to remove as much as possible OS maintenance in a Kubernetes cluster. 
> It is specifically designed to only have what is need to run k3s. Additionally the OS is designed to be managed by kubectl once a cluster is bootstrapped. 
> Nodes only need to join a cluster and then all aspects of the OS can be managed from Kubernetes. Both k3OS and k3s upgrades are handled by the k3OS operator.

Software installation via Alpine's apk is not supported.

## K3S
- traffik & klipper-lb 구조
