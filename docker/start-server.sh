#!/bin/bash

# Настройка временной зоны, если необходимо
export TZ=Europe/London

# Запуск Xvfb
Xvfb :1 -screen 0 1080x1920x24 &

# Запуск x11vnc
x11vnc -display :1 -forever -shared -rfbport 5900 &

# Запуск noVNC
/noVNC/utils/launch.sh --vnc localhost:5900 --listen 6080
