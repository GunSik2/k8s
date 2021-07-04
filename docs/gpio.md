# Rasberry Pi with Ubuntu GPIO + K3s

## 사전작업
Prepare [raseberrypi](raspberrypi.md)

## GPIO 설치
```
sudo apt install python3-gpiozero
sudo reboot
```
## LED 예제
- GPIO 연결 : 
  - LED 짧은 라인 GROUND 연결
  - LBE 긴 라인 저항 연결 및 GPIO17 연결
- 코드 테스트
```
from gpiozero import LED
from signal import pause

red = LED(17)

red.blink()

pause()
```

```
import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BCM)
GPIO.setup(17,GPIO.OUT)

while True:
  GPIO.output(17,True)
  time.sleep(1)
  GPIO.output(17,False)
  time.sleep(1)

GPIO.cleanup()

```


## 참고
- https://ubuntu.com/tutorials/gpio-on-raspberry-pi#2-installing-gpio
- https://gpiozero.readthedocs.io/en/stable/recipes.html#led
- https://www.slideshare.net/ssuserc5886a/running-k3s-on-raspberry-pi
