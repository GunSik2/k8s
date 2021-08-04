
## Install
- script 설치 
```
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.19.2
```
- [다양한 설치 방법](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/installation/)

## 예시
- Scan image for vulnerabilities
```
# trivy image python:3.4-alpine
```
- Scan directory for misconfigurations
```
# ls build/
Dockerfile
# trivy config ./build
```

## reference
- https://aquasecurity.github.io/trivy
