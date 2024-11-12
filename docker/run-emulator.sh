#!/bin/bash

# Запуск adb-сервера
adb start-server

# Запуск эмулятора Android
$ANDROID_SDK_ROOT/emulator/emulator -avd test -no-window -no-audio -gpu host -accel on -qemu -enable-kvm

