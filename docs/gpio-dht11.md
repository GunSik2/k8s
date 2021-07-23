# DHT11 온습도 연동 

## 구성
![image](https://user-images.githubusercontent.com/11453229/124472206-cbfd9480-ddd8-11eb-8183-6f22edd9f988.png)
![image](https://user-images.githubusercontent.com/11453229/126845447-dccd49af-436f-443f-9bc4-c0267c136618.png)
- (1st, Left) DHT11/22 Sensor Vcc+ to Raspberry Pi 5V
- (2nd, Middle) DHT11/22 Sensor Signal to Raspberry Pi PIN 7 (GPIO PIN 4)
- (3rd, Rigth) DHT11/22 Sensor GND to Raspberry Pi GND

## Python
- package installation
```
sudo apt-get install python3-dev python3-pip
sudo python3 -m pip install --upgrade pip setuptools wheel
```
- python program
```
import Adafruit_DHT
import time
 
DHT_SENSOR = Adafruit_DHT.DHT11
DHT_PIN = 4
 
while True:
    humidity, temperature = Adafruit_DHT.read(DHT_SENSOR, DHT_PIN)
    if humidity is not None and temperature is not None:
        print("Temp={0:0.1f}C Humidity={1:0.1f}%".format(temperature, humidity))
    else:
        print("Sensor failure. Check wiring.");
    time.sleep(3);
```

## 참고
- https://www.thegeekpub.com/236867/using-the-dht11-temperature-sensor-with-the-raspberry-pi/
