#!/bin/bash

export DISPLAY=:99

# Ensure correct permissions on /tmp/.X11-unix
chmod -R 1777 /tmp/.X11-unix
chown root:root /tmp/.X11-unix

# Wait for Xvfb to start
for i in {1..10}; do
    if xset -display :99 q &>/dev/null; then
        echo "Xvfb is ready."
        break
    fi
    echo "Waiting for Xvfb to start..."
    sleep 2
done

# Start ADB server
adb start-server

# Start Android emulator
$ANDROID_SDK_ROOT/emulator/emulator -avd test -no-window -no-audio -port 5554 -gpu swiftshader_indirect -accel on -qemu -enable-kvm

# Allow time for emulator startup
sleep 30

# Switch ADB to TCP mode and connect
adb -s emulator-5554 tcpip 5555
adb connect localhost:5555
