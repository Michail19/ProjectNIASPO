#!/bin/bash

# Запуск виртуального дисплея Xvfb
Xvfb :1 -screen 0 1024x768x16 &
export DISPLAY=:1

# Запуск VNC-сервера x11vnc
x11vnc -display :0 -forever -shared -rfbport 5900 &

# Запуск Android эмулятора с KVM и GPU хоста
$ANDROID_HOME/emulator/emulator -avd test_avd -no-window -no-audio -gpu host -accel on -qemu -enable-kvm &

# Пауза, чтобы убедиться, что эмулятор запустился
adb wait-for-device

# Вывод состояния эмулятора для отладки
adb devices

# Бесконечный цикл, чтобы контейнер оставался активным
while true; do
    sleep 1000
done
