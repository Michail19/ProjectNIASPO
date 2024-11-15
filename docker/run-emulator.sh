#!/bin/bash

export DISPLAY=:99
export XDG_RUNTIME_DIR=/tmp
export LIBGL_ALWAYS_SOFTWARE=1

# Создаем директорию .android, если она не существует
mkdir -p /root/.android
chmod -R 755 /root/.android

# Обеспечиваем правильные права на /tmp/.X11-unix
chmod -R 1777 /tmp/.X11-unix
chown root:root /tmp/.X11-unix

# Ждем запуска Xvfb
for i in {1..10}; do
    if xdpyinfo -display :99 &>/dev/null; then
        echo "Xvfb is ready."
        break
    fi
    echo "Waiting for Xvfb to start..."
    sleep 2
done

# Запускаем ADB сервер
adb start-server

# Запускаем эмулятор Android
$ANDROID_SDK_ROOT/emulator/emulator -avd test -no-window -no-audio -port 5554 -gpu swiftshader_indirect -accel on -qemu -enable-kvm &

# Ждем завершения загрузки эмулятора
boot_completed=""
while [ "$boot_completed" != "1" ]; do
    boot_completed=$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')
    echo "Waiting for emulator to boot..."
    sleep 5
done

echo "Emulator boot completed."

# Оставляем контейнер активным
tail -f /dev/null
