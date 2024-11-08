#!/bin/bash

# Настройка временной зоны, если необходимо
export TZ=Europe/London

# Запуск Xvfb
Xvfb :99 -screen 0 1024x768x16 &

# Запуск x11vnc
x11vnc -display :99 -forever -shared -rfbport 5900 &

# Запуск noVNC
/noVNC/utils/launch.sh --vnc localhost:5900 --listen 6080
