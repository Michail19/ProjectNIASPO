#!/bin/bash

# Запуск x11vnc для подключения к X-сессии
x11vnc -display :0 -nopw -forever &

# Запуск noVNC через скрипт launch.sh, если он доступен
if [ -f /usr/share/novnc/utils/launch.sh ]; then
    /usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 6080
else
    # В случае отсутствия launch.sh используем websockify напрямую
    websockify --web /usr/share/novnc 6080 localhost:5900
fi
