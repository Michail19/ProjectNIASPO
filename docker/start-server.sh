#!/bin/bash

# Запуск оконного менеджера (Fluxbox)
fluxbox &
sleep 2  # Небольшая задержка для запуска fluxbox

# Запуск x11vnc для подключения к X-сессии
x11vnc -display :99 -noshm -nopw -forever -noxdamage -fixscreen 30 -nowf &
sleep 2  # Даем время для запуска x11vnc

# Проверка наличия launch.sh и запуск noVNC
if [ -f /usr/share/novnc/launch.sh ]; then
    /usr/share/novnc/launch.sh --vnc localhost:5900 --listen 6080 &
else
    # Запуск websockify, если launch.sh недоступен
    websockify --web /usr/share/novnc 6080 localhost:5900 &
fi

# Ожидание завершения фоновых процессов, чтобы контейнер оставался активным
wait
