#!/bin/bash

# Запуск виртуального дисплея Xvfb
Xvfb :0 -screen 0 1080x1920x24 &
export DISPLAY=:0

if ! pgrep -x "Xvfb" > /dev/null; then
    echo "Ошибка: Xvfb не запущен" >&2
    exit 1
fi

# Запуск VNC-сервера x11vnc
x11vnc -display :0 -forever -shared -rfbport 5900 &

# Проверка наличия AVD
if ! $ANDROID_HOME/emulator/emulator -list-avds | grep -q "test_avd"; then
    echo "Ошибка: AVD 'test_avd' не существует" >&2
    exit 1
fi

# Запуск Android эмулятора с логированием
$ANDROID_HOME/emulator/emulator -avd test_avd -no-window -no-audio -gpu host -accel on -qemu -enable-kvm > emulator.log 2>&1 &

# Пауза для запуска эмулятора
adb wait-for-device

# Проверка подключения ADB
adb kill-server
adb start-server
adb devices

# Оставляем контейнер активным, пока эмулятор работает
wait $!
