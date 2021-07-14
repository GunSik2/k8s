# Jetson Deep Learning with Camera
## 준비사항
- Nana 준비 및 로지택 카메라 설치 상태

## Jpyter 실행 및 시험
- Jupyter 설치
```
# mkdir ~/nvdli-data

# echo "sudo docker run --runtime nvidia -it --rm --network host \
    --volume ~/nvdli-data:/nvdli-nano/data \
    --device /dev/video0 \ 
    nvcr.io/nvidia/dli/dli-nano-ai:v2.0.1-r32.5.0" >  docker_dli_run.sh
# chmod +x docker_dli_run.sh
# ./docker_dli_run.sh 
    
allow 10 sec for JupyterLab to start @ http://192.168.55.1:8888 (password dlinano)
JupterLab logging location:  /var/log/jupyter.log  (inside the container)
You can then navigate the browser on your PC to the URL shown above (http://192.168.55.1:8888) and login to JupyterLab with the password dlinano. Then proceed with the DLI course as normal.    
```
- 브라우저 접속하여 Jupyter 환경에서 진행 (Enter the password: dlinano)
- hello_camera > usb_camera.ipynb 노트북 열기
 
## AI & DeepLarning 
- Convolution (합성곱) 하나의 함수와 또 다른 함수를 반전 이동한 값을 곱하고, 구간 적분하여 새로운 함수를 만드는 수학 연산자
- 
### RseNet-18 ([Go](https://courses.nvidia.com/courses/course-v1:DLI+S-RX-02+V2/courseware/b2e02e999d9247eb8e33e893ca052206/26aa9f8bdaa948d9b068a8275c89e546/?child=first))
- Residual Networks : 
  - 복수의 레이어를 스킵하는 단축 연결 블럭을 추가함으로서, 네트워크 효율성과 정확성이 증가됨
  - ResNet은 18 개 레이어부터 152 레이어 제시함. Nano는 18개 사용
- Transfer Learning 
  - 1000 개 이미지 훈련된 모델을 이용하여 10개 클래스를 구분하는 시험 진행 
  - 마지막 18번째 레이어 출력값을 (512,1000) layer 에서 (512, 10)출력으로 변경
### Thumbs Project

## 이미지 참고
### Convolution
![image](https://user-images.githubusercontent.com/11453229/125649165-b84cb846-f732-4565-9683-7c963490a7d2.png)
### Residual Network
![image](https://user-images.githubusercontent.com/11453229/125651360-09b74b30-a75d-4ce7-a390-f2590b639c25.png)

## 참고자료
- https://courses.nvidia.com/courses/course-v1:DLI+S-RX-02+V2/
- https://ngc.nvidia.com/catalog/containers/nvidia:dli:dli-nano-ai
- https://blogs.nvidia.com/blog/2020/10/06/jetson-nano-2gb-duckietown/
