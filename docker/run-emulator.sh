#!/bin/bash

# Запуск виртуального дисплея Xvfb
Xvfb :0 -screen 0 1280x720x16 &  # Разрешение можно настроить по необходимости
export DISPLAY=:0

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
