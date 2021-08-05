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

- PostgreSQL Client 
```
$ docker run -it --rm \
  --network host \
  bitnami/postgresql:10 \
  psql -h pg-0 -U postgres
```

## Reference
- https://github.com/ibrokethecloud/k3s-ha
- https://github.com/bitnami/bitnami-docker-postgresql-repmgr
