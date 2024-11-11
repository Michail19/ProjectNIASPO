#!/bin/bash

# Задаем порт ADB
export ANDROID_ADB_SERVER_PORT=5037

# Запускаем ADB сервер на новом порту
adb -P $ANDROID_ADB_SERVER_PORT start-server

# Запуск fluxbox для оконного управления
fluxbox &

# Запуск виртуального дисплея Xvfb на :0
Xvfb :0 -screen 0 1280x720x16 &

# Запуск VNC-сервера для дисплея
x11vnc -display :0 -forever -shared -rfbport 5900 -noxdamage -ncache 10 &

# Запуск Android эмулятора
$ANDROID_HOME/emulator/emulator -avd test_avd -port 5554 -no-window -no-audio -gpu host -accel on -qemu -enable-kvm -partition-size 2048 -memory 1024 &

# Ожидание загрузки эмулятора
sleep 30
adb wait-for-device

# Удерживаем контейнер активным
wait $!
