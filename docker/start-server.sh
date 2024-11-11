#!/bin/bash
# start-server.sh

# Запуск websockify для передачи X-сессии в web
websockify -D --web /usr/share/novnc/ 6080 localhost:5900
