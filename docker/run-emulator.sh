#!/bin/bash

export DISPLAY=:99
export XDG_RUNTIME_DIR=/tmp
export LIBGL_ALWAYS_SOFTWARE=1
export ADB_SERVER_PORT=5037

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

# Запускаем эмулятор Android
$ANDROID_SDK_ROOT/emulator/emulator -avd test -no-audio -port 5554 -no-skin -gpu host -accel on -qemu -enable-kvm &

sleep 15

# Запускаем ADB сервер
#ADB_SERVER_SOCKET=/tmp/adb/adb.sock adb -a -P 5037 start-server
adb -a -P 5037 start-server
# adb start-server

# Ждём, пока adb станет доступен
for i in {1..10}; do
    # if adb get-state >/dev/null 2>&1; then
    if adb get-state >/tmp/adb/adb.log 2>&1; then
        echo "ADB is responding."
        break
    fi
    echo "Waiting for adb to respond... (Attempt $i)"
    sleep 2
done

ls -la /tmp/adb

# Ждем завершения загрузки эмулятора
boot_completed=""
while [ "$boot_completed" != "1" ]; do
    # boot_completed=$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')
    boot_completed=$(adb shell getprop sys.boot_completed 2>/tmp/adb/adb.log | tr -d '\r')
    echo "Waiting for emulator to boot..."
    sleep 5
done

echo "Emulator boot completed."

# Оставляем контейнер активным
# tail -f /dev/null
tail -f /tmp/adb/adb.log
