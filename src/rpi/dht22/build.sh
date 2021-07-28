name=rpi-dht22

docker build -t cgshome2/$name .

#docker run --privileged cgshome2/$name

docker push cgshome2/$name
