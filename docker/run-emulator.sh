#!/bin/bash

# Запуск виртуального дисплея
Xvfb :0 -screen 0 1280x800x16 &

# Запуск эмулятора Android
$ANDROID_SDK_ROOT/emulator/emulator -avd test -no-window -no-audio -gpu swiftshader_indirect -accel on -qemu -enable-kvm
