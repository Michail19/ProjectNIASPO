#!/bin/bash

# Запуск виртуального дисплея Xvfb
Xvfb :0 -screen 0 1080x1920x24 &
export DISPLAY=:0

# Запуск VNC-сервера x11vnc
x11vnc -display :0 -forever -shared -rfbport 5900 &

# Запуск Android эмулятора с логированием
$ANDROID_HOME/emulator/emulator -avd test_avd -no-window -no-audio -gpu swiftshader_indirect -accel on -qemu -enable-kvm &

# Пауза для запуска эмулятора
adb wait-for-device

# Оставляем контейнер активным, пока эмулятор работает
wait $!
