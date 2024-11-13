#!/bin/bash

# Ensure the correct permissions on /tmp/.X11-unix
sudo chown root:root /tmp/.X11-unix

# Запуск adb-сервера
adb start-server

# Запуск эмулятора Android
$ANDROID_SDK_ROOT/emulator/emulator -avd test -no-window -no-audio -gpu host -accel on -qemu -enable-kvm

