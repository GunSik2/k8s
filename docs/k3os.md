# K3os 


## wifi 활성화
```
# cp /k3os/system/config.yaml /var/lib/rancher/k3os/config.yaml
# cat /var/lib/rancher/k3os/config.yaml 
hostname: vmops
k3os:
  ...
  wifi:
  - name: Crossent_5G
    passphrase: crossent
```

## 참고자료
- [k3os 설정](https://github.com/rancher/k3os#configuration-reference)
