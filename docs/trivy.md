Trivy 이미지 취약점 분석


## Install
- script 설치 
```
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.19.2
```
- [다양한 설치 방법](https://aquasecurity.github.io/trivy/v0.19.2/getting-started/installation/)

## 실행 예시
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

## 확장
- [Grafana 이미지 취약점 데시보드](https://grafana.com/grafana/dashboards/12331)
- [Github Action 연동](https://blog.aquasec.com/github-vulnerability-scanner-trivy)

## reference
- https://aquasecurity.github.io/trivy
