# Ubuntu 20.04 + RKE2 + Harvester
## Ubuntu 20.04
- enable ssh
```
$ sudo apt update
$ sudo apt install openssh-server
$ sudo systemctl status ssh
$ sudo ufw allow ssh
```
- install curl
```
$ sudo apt install curl -y 
```
- install helm cli
```
$ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```
## RKE2 
- Install RKE2
```
curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service
journalctl -u rke2-server -f
```
- Check
```
export PATH=$PATH:/var/lib/rancher/rke2/bin
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml

kubectl get nodes
kubectl get pods --all-namespaces
helm ls --all-namespaces
```
## Harvester
- Prepare
```
kubectl create ns harvester-system

apt install git -y
git clone https://github.com/harvester/harvester/
cd harvester; git checkout stable; cd deploy/charts/
```
- Update values
```
$ cat harvester/values.yml
minio:
  enabled: false
  
multus:
  enabled: true

longhorn:
  enabled: true
```
- Install
```
helm install harvester ./harvester --namespace harvester-system --set service.harvester.type=NodePort
```
## Harvester-UI


## Rancher
- repo
```
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system
```
- cert-manager
```
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.4/cert-manager.crds.yaml
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.0.4

	
kubectl get pods -n cert-manager
```
- Rancher
```
helm upgrade --install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.example.com \
  --set replicas=1 
  # --set proxy="http://proxy.example.com:80/" \
  # --set noProxy=".example.com\,169.254.169.254\,10.0.0.0/24"
  
kubectl get pods -A  
```


## Reference
- https://docs.rke2.io/install/quickstart/
- https://github.com/harvester/harvester/blob/master/deploy/charts/harvester/README.md
- https://blogs.aca-it.be/how-to-install-rancher-rke2-on-centos-stream-8/
- https://github.com/harvester/harvester-ui
