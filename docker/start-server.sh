#!/bin/bash

# Запуск виртуального дисплея
Xvfb :0 -screen 0 1280x800x16 &

# Запуск оконного менеджера
fluxbox &

# Запуск x11vnc для подключения к X-сессии
x11vnc -display :0 -noshm -nopw -forever &

# Запуск noVNC через launch.sh или websockify
if [ -f /usr/share/novnc/utils/launch.sh ]; then
    /usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 6080
else
    websockify --web /usr/share/novnc 6080 localhost:5900
fi
