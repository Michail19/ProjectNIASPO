#!/bin/bash
# Запуск x11vnc
x11vnc -display :0 -forever -shared -rfbport 5900 &
# Запуск noVNC
/usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 6080
