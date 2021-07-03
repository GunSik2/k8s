# Rasberry Pi with Ubuntu GPIO 

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

## 참고
- https://ubuntu.com/tutorials/gpio-on-raspberry-pi#2-installing-gpio
- https://gpiozero.readthedocs.io/en/stable/recipes.html#led

