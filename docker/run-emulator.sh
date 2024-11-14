#!/bin/bash

# Ensure the correct permissions on /tmp/.X11-unix
chmod -R 1777 /tmp/.X11-unix
chown root:root /tmp/.X11-unix

# Запуск adb-сервера
adb start-server

# Запуск эмулятора Android
$ANDROID_SDK_ROOT/emulator/emulator -avd test -no-window -no-audio -port 5554 -gpu host -accel on -qemu -enable-kvm

# Ждем некоторое время для старта эмулятора
sleep 30

# Переключаем ADB на TCP и подключаемся
adb -s emulator-5554 tcpip 5555
adb connect localhost:5555
