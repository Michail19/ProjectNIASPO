#!/bin/bash

# Название сервиса из docker-compose (замените, если используется другое имя)
SERVICE_NAME=docker-gradle-1

# Сборка APK
/app/gradlew -p /app assembleDebug

# Установка APK на эмулятор
adb -s emulator-5554 install -r /app/app/build/outputs/apk/debug/app-debug.apk

# Запуск приложения
adb -s emulator-5554 shell monkey -p com.me.projectniaspo -c android.intent.category.LAUNCHER 1