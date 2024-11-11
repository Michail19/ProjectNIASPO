#!/bin/bash
# run-emulator.sh

# Запуск виртуального дисплея
Xvfb :0 -screen 0 1280x720x24 &

# Ожидание, чтобы Xvfb успел запуститься
sleep 5

# Запуск эмулятора
emulator -avd Android_Emulator -no-skin -no-audio -no-window -gpu off -qemu -m 2048
