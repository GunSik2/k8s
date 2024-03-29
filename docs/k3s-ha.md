# K3s HA

## Archtecture
Simple shell script to setup a simple 2 node k3s HA cluster

The script will setup the following:

- Bitnami PostgreSQL HA containers for perisistence
- Keepalived for k3s apiserver and postgres endpoint
- K3s server using the said vip and postgres db
- The script needs to following arguments

```
k3s-ha.sh PRIMARY_IP SECONDARY_IP VIRTUAL_IP ROLE(MASTER/BACKUP)
```

Once the cluster is up, the user can save the k3s clusters KUBECONFIG file locally.

Please ensure that the server address in the KUBECONFIG points to the predefined VIP.

This should allow cluster to be accessible even if the primary node fails


![image](https://user-images.githubusercontent.com/11453229/128290681-2d4f79da-bd7e-4372-a14b-ff764210ff28.png)

## Run
- master node
```
sudo su -
apt  install  net-tools docker.io -y
wget https://raw.githubusercontent.com/GunSik2/k8s/main/install/k3s-ha.sh
. k3s-ha.sh 192.168.0.3 192.168.0.9 192.168.0.11 MASTER
```
- backup node
```
sudo su -
apt  install  net-tools docker.io -y
wget https://raw.githubusercontent.com/GunSik2/k8s/main/install/k3s-ha.sh
. k3s-ha.sh 192.168.0.3 192.168.0.9 192.168.0.11 BACKUP
```
## Script Code
- PosgreSQL HA
```
if [ ${ROLE} = "MASTER" ]; then
echo "booting postgres master"
docker run --detach --name pg-0 \
  --publish 5432:5432 \
  --add-host pg-0:${NODE1} \
  --add-host pg-1:${NODE2} \
  --env REPMGR_PARTNER_NODES="pg-0,pg-1" \
  --env REPMGR_NODE_NAME=pg-0 \
  --env REPMGR_NODE_NETWORK_NAME=pg-0 \
  --env REPMGR_PRIMARY_HOST=pg-0 \
  --env REPMGR_PASSWORD=$REPMGR_PASSWORD \
  --env POSTGRESQL_PASSWORD=$POSTGRESQL_PASSWORD \
  --volume /var/lib/rancher/postgres:/bitnami/postgresql/data \
  --restart always \
  bitnami/postgresql-repmgr:latest
else 
echo "booting postgres slave"
docker run --detach --name pg-1 \
  --publish 5432:5432 \
  --add-host pg-0:${NODE1} \
  --add-host pg-1:${NODE2} \
  --env REPMGR_PARTNER_NODES="pg-0,pg-1" \
  --env REPMGR_NODE_NAME=pg-1 \
  --env REPMGR_NODE_NETWORK_NAME=pg-1 \
  --env REPMGR_PRIMARY_HOST=pg-0 \
  --env REPMGR_PASSWORD=$REPMGR_PASSWORD \
  --env POSTGRESQL_PASSWORD=$POSTGRESQL_PASSWORD \
  --restart always \
  --volume /var/lib/rancher/postgres:/bitnami/postgresql/data \
  bitnami/postgresql-repmgr:latest
fi  
```

- Keepalived
  :  require the kernel module ip_vs loaded on the host (modprobe ip_vs) 
```
echo "firing up keepalived"
docker run \
  --cap-add=NET_ADMIN \
  --cap-add=NET_BROADCAST \
  --cap-add=NET_RAW \
  --net=host \
  --env KEEPALIVED_INTERFACE=$DEFAULT_IF \
  --env KEEPALIVED_UNICAST_PEERS="#PYTHON2BASH:[$NODE1, $NODE2]" \
  --env KEEPALIVED_STATE=$ROLE \
  --env KEEPALIVED_VIRTUAL_IPS=$VIRTUAL_IP \
  --name vip \
  --restart always \
  -d osixia/keepalived:2.0.20
```

- k3s
```
echo "booting k3s with external db"
curl -sfL https://get.k3s.io | sh -s - server --tls-san $VIRTUAL_IP \
  --datastore-endpoint="postgres://postgres:secretpass@$VIRTUAL_IP:5432/kine?sslmode=disable" 
```

- Check cluster status
```
docker exec -it pg-0 bash
# /opt/bitnami/scripts/postgresql-repmgr/entrypoint.sh repmgr -f /opt/bitnami/repmgr/conf/repmgr.conf cluster show

 ID   | Name | Role    | Status    | Upstream | Location | Priority | Timeline | Connection string                                                                  
------+------+---------+-----------+----------+----------+----------+----------+-------------------------------------------------------------------------------------
 1000 | pg-0 | primary | * running |          | default  | 100      | 1        | user=repmgr password=repmgrpass host=pg-0 dbname=repmgr port=5432 connect_timeout=5
 1001 | pg-1 | standby |   running | pg-0     | default  | 100      | 1        | user=repmgr password=repmgrpass host=pg-1 dbname=repmgr port=5432 connect_timeout=5

#/opt/bitnami/scripts/postgresql-repmgr/entrypoint.sh repmgr -f /opt/bitnami/repmgr/conf/repmgr.conf service status

 ID | Name | Role    | Status    | Upstream | repmgrd | PID | Paused? | Upstream last seen
----+------+---------+-----------+----------+---------+-----+---------+--------------------
 1000 | pg-0 | primary | * running |          | running | 1   | no      | n/a                
 1001 | pg-1 | standby |   running | pg-0     | running | 1   | no      | 0 second(s) ago 
 
 # psql -U postgres
 password: secretpass
 postgres=# \l
 postgres=# \c kine
 kine=# \dt
         List of relations
 Schema | Name | Type  |  Owner   
--------+------+-------+----------
 public | kine | table | postgres
kine=# \d kine
```

## K3s modification
### k3s no start
- k3s 설치만 먼저, 기동은 하지 않고
```
curl -sfL https://get.k3s.io | INSTALL_K3S_SKIP_START=false sh -
```

### keepalived
- k3s 는 containerd 기반 실행
- containerd 기본 cli 인 ctr 은 docker 와 명령체계가 상이함
- containerd 와 호환되며 docker와 명령체계가 유사한 nerdctl 을 사용하여 실행
- k3s 환경은 기본 containerd 와 상이한 설정이 있으므로 nerdctl 명령 실행 시 부가 옵션 설정 필요
- (--address /run/k3s/containerd/containerd.sock --namespace k8s.io)
- nerdctl 설치
```
wget -c https://github.com/containerd/nerdctl/releases/download/v0.11.0/nerdctl-0.11.0-linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local/bin/
```
- 업데이트한 keepalived 배포 스크립트
```
NODE1=192.168.0.19
NODE2=192.168.0.25
DEFAULT_IF=enp1s0
VIRTUAL_IP=192.168.0.49
ROLE=MASTER  #/BACKUP

alias docker="nerdctl --address /run/k3s/containerd/containerd.sock --namespace k8s.io"

docker run \
  --cap-add=NET_ADMIN \
  --cap-add=NET_BROADCAST \
  --cap-add=NET_RAW \
  --net=host \
  --env KEEPALIVED_INTERFACE=$DEFAULT_IF \
  --env KEEPALIVED_UNICAST_PEERS="#PYTHON2BASH:[$NODE1, $NODE2]" \
  --env KEEPALIVED_STATE=$ROLE \
  --env KEEPALIVED_VIRTUAL_IPS=$VIRTUAL_IP \
  --name vip \
  --restart always \
  -d osixia/keepalived:2.0.20
```



## Reference
- https://github.com/ibrokethecloud/k3s-ha
- https://github.com/bitnami/bitnami-docker-postgresql-repmgr
- https://github.com/osixia/docker-keepalived
- https://github.com/containerd/nerdctl
- https://repmgr.org/docs/current/index.html
