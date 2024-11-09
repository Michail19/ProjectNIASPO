#!/bin/bash

# Запуск noVNC, соединенного с VNC-сервером, запущенным в контейнере emulator
/noVNC/utils/launch.sh --vnc emulator:5900 --listen 6080
