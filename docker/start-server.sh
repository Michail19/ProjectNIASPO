#!/bin/bash

# Запуск x11vnc для подключения к X-сессии
x11vnc -display :0 -nopw -forever &

# Запуск noVNC сервера
novnc --vnc localhost:5900 --listen 6080
