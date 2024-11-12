#!/bin/bash

# Запуск виртуального дисплея на дисплее :0
Xvfb :0 -screen 0 1280x800x16 &
sleep 2  # Даем немного времени для запуска Xvfb

# Запуск оконного менеджера (Fluxbox)
fluxbox &
sleep 2  # Небольшая задержка для запуска fluxbox

# Запуск x11vnc для подключения к X-сессии
x11vnc -display :0 -noshm -nopw -forever -rfbport 5900 &
sleep 2  # Даем время для запуска x11vnc

# Проверка наличия launch.sh и запуск noVNC
if [ -f /usr/share/novnc/utils/launch.sh ]; then
    /usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 6080 &
else
    # Запуск websockify, если launch.sh недоступен
    websockify --web /usr/share/novnc 6080 localhost:5900 &
fi

# Ожидание завершения фоновых процессов, чтобы контейнер оставался активным
wait
