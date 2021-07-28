
# K3s with Jetson

## Jetson 이미지 테스트
- Jetson GPU 쿼리 이미지 생성 및 테스트
```
cp /usr/local/cuda/samples/ . -r
vi Dockerfile.deviceQuery
---
FROM nvcr.io/nvidia/l4t-base:r32.5.0
RUN apt-get update && apt-get install -y --no-install-recommends make g++
COPY ./samples /tmp/samples
WORKDIR /tmp/samples/1_Utilities/deviceQuery
RUN make clean && make
CMD ["./deviceQuery"]
---
sudo docker build -t cgshome2/jetson_devicequery:32.5 . -f  Dockerfile.deviceQuery
sudo docker run --rm --runtime nvidia cgshome2/jetson_devicequery:32.5
```
- 이미지 업로드
```
sudo docker login
sudo docker push cgshome2/jetson_devicequery:32.5
```
- Containerd로 이미지 시험
```
ctr i pull docker.io/cgshome2/jetson_devicequery:32.5
sudo ctr run --rm --gpus 0 --tty  docker.io/cgshome2/jetson_devicequery:32.5 deviceQuery
```

## K3S 배포
```
cat pod_deviceQuery.yml 
---
apiVersion: v1
kind: Pod
metadata:
  name: devicequery
spec:
  nodeName: jetson
  containers:
  - name: nvidia
    image: cgshome2/jetson_devicequery:32.5
    command: [ "./deviceQuery" ]
---
sudo kubectl apply -f pod_deviceQuery.yml 
kubectl describe pod devicequery
kubectl logs devicequery
```


## 참고
- [Run an Edge AI K3s Cluster on NVIDIA Jetson Nano Boards](https://www.suse.com/c/running-edge-artificial-intelligence-k3s-cluster-with-nvidia-jetson-nano-boards-src/)
