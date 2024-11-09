#!/bin/bash

# Запуск виртуального дисплея Xvfb
Xvfb :0 -screen 0 1080x1920x24 &
export DISPLAY=:0
echo "Xvfb запущен на дисплее $DISPLAY"

# Запуск VNC-сервера x11vnc
x11vnc -display :0 -forever -shared -rfbport 5900 &
echo "VNC-сервер запущен на дисплее $DISPLAY"

# Запуск Android эмулятора с логированием
$ANDROID_HOME/emulator/emulator -avd test_avd -no-window -no-audio -gpu swiftshader_indirect -accel on -qemu -enable-kvm &
echo "Эмулятор запущен"

# Даем эмулятору время на загрузку
sleep 30

# Проверка состояния эмулятора
adb wait-for-device && echo "Эмулятор доступен через adb" || echo "Эмулятор не доступен через adb"

# Оставляем контейнер активным, пока эмулятор работает
wait $!
