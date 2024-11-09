#!/bin/bash

# Запуск виртуального дисплея Xvfb на :0
Xvfb :0 -screen 0 1080x1920x24 &
export DISPLAY=:0

# Запуск VNC-сервера для дисплея
x11vnc -display :0 -forever -shared -rfbport 5900 -ncache 10 -noxdamage &

# Запуск Android эмулятора
$ANDROID_HOME/emulator/emulator -avd test_avd -no-window -no-audio -gpu host -accel on -qemu -enable-kvm &

# Ожидание загрузки эмулятора
sleep 30
adb wait-for-device

# Удерживаем контейнер активным
wait $!
