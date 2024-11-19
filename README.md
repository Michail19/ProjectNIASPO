# CI/CD Процесс для Мобильного Приложения

## Описание проекта

Настройка и администрирование CI/CD процесса для мобильного приложения, включая:
* Автоматизированный запуск Android эмулятора в контейнере.
* Интеграция с пайплайнами CI/CD для сборки и тестирования приложений.
* Управление виртуальными устройствами через Docker Compose.

------------------------
## Содержание
1) [Особенности проекта](#особенности-проекта)
2) [Как использовать](#как-использовать)
3) [Требования](#требования)
4) [Запуск](#запуск)
5) [Архитектура](#архитектура)
6) [Подробности реализации](#подробности-реализации)
7) [FAQ](#faq)

------------------------
## Особенности проекта

* **Контейнеризация CI/CD:** Среда на основе Docker Compose с Android эмулятором и поддержкой тестирования приложений.
* **Виртуализация эмулятора:** Используется Xvfb для работы без графического интерфейса и NoVNC для отладки.
* **Автоматизация запуска:** Проверка состояния эмулятора с помощью healthcheck и adb shell getprop sys.boot_completed.
* **Гибкость и масштабируемость:** Лёгкая адаптация под любые мобильные проекты.

------------------------
## Как использовать

1. **Клонирование репозитория**

```bash
git clone https://github.com/Michail19/ProjectNIASPO.git
cd ProjectNIASPO
```

2. **Настройка Docker Compose**

Откройте файл ``docker/docker-compose.yml`` и проверьте настройки портов, ресурсов и переменных среды.

3. **Запуск среды**

Запустите окружение с помощью команды:

```bash
docker-compose -f ./docker/docker-compose.yml up --build
```

Эмулятор начнёт загрузку, а состояние можно проверить через:

```bash
docker-compose ps
```

------------------------
## Требования

* **ОС:** Linux, Windows или MacOS с поддержкой Docker.
* **Docker:** Версия 20.10 или выше.
* **Docker Compose:** Версия 2.0 или выше.
* **Поддержка KVM:** Для эмуляции Android (Linux) или Hyper-V (Windows).

------------------------
## Запуск

### Проверка эмулятора

Чтобы убедиться, что эмулятор запущен и готов к использованию:

```bash
adb devices
```

Вывод должен включать:

```
List of devices attached
emulator-5554 device
```

### Установка APK

Для тестирования приложения, можно загрузить файл APK в контейнер:

```bash
adb install /путь/к/вашему/приложению.apk
```

``install_and_run.sh`` уже имеет предустановленный APK, и запустит его после окончания сборки проекта в сервисе Gradle. 

------------------------
## Архитектура

Архитектура проекта содержит чёткое структурированное распределение подкаталогов по их назначению.


```
ProjectNIASPO
├── app
│   ├── build.gradle
│   ├── proguard-rules.pro
│   └── src
│       ├── androidTest
│       │   └── java
│       │       └── com
│       │           └── me
│       │               └── projectniaspo
│       │                   └── ExampleInstrumentedTest.java
│       ├── main
│       │   ├── AndroidManifest.xml
│       │   ├── java
│       │   │   └── com
│       │   │       └── me
│       │   │           └── projectniaspo
│       │   │               ├── FirstFragment.java
│       │   │               ├── MainActivity.java
│       │   │               └── SecondFragment.java
│       │   └── res
│       │       ├── drawable
│       │       │   └── ic_launcher_background.xml
│       │       ├── drawable-v24
│       │       │   └── ic_launcher_foreground.xml
│       │       ├── layout
│       │       │   ├── activity_main.xml
│       │       │   ├── content_main.xml
│       │       │   ├── fragment_first.xml
│       │       │   └── fragment_second.xml
│       │       ├── menu
│       │       │   └── menu_main.xml
│       │       ├── mipmap-anydpi-v26
│       │       │   ├── ic_launcher_round.xml
│       │       │   └── ic_launcher.xml
│       │       ├── mipmap-hdpi
│       │       │   ├── ic_launcher_round.webp
│       │       │   └── ic_launcher.webp
│       │       ├── mipmap-mdpi
│       │       │   ├── ic_launcher_round.webp
│       │       │   └── ic_launcher.webp
│       │       ├── mipmap-xhdpi
│       │       │   ├── ic_launcher_round.webp
│       │       │   └── ic_launcher.webp
│       │       ├── mipmap-xxhdpi
│       │       │   ├── ic_launcher_round.webp
│       │       │   └── ic_launcher.webp
│       │       ├── mipmap-xxxhdpi
│       │       │   ├── ic_launcher_round.webp
│       │       │   └── ic_launcher.webp
│       │       ├── navigation
│       │       │   └── nav_graph.xml
│       │       ├── values
│       │       │   ├── colors.xml
│       │       │   ├── dimens.xml
│       │       │   ├── strings.xml
│       │       │   └── themes.xml
│       │       ├── values-land
│       │       │   └── dimens.xml
│       │       ├── values-night
│       │       │   └── themes.xml
│       │       ├── values-w1240dp
│       │       │   └── dimens.xml
│       │       ├── values-w600dp
│       │       │   └── dimens.xml
│       │       └── xml
│       │           ├── backup_rules.xml
│       │           └── data_extraction_rules.xml
│       └── test
│           └── java
│               └── com
│                   └── me
│                       └── projectniaspo
│                           └── ExampleUnitTest.java
├── build.gradle
├── docker
│   ├── artifacts
│   ├── docker-compose.yml
│   ├── Dockerfile-artifact-repo
│   ├── Dockerfile-emulator
│   ├── Dockerfile-gradle
│   ├── Dockerfile-linter
│   ├── Dockerfile-novnc
│   ├── start-server.sh
│   ├── install_and_run.sh
│   ├── nginx.conf
│   └── run-emulator.sh
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradle.properties
├── gradlew
├── gradlew.bat
├── local.properties
├── README.md
└── settings.gradle
```

 ------------------------
## Подробности реализации

1. **Docker Compose**

Сервисы:

* xvfb: Виртуальный дисплей для работы эмулятора.
* emulator: Android эмулятор с ADB-сервером.
* novnc: Веб-доступ к эмулятору через VNC и noVNC через браузер.

2. **Healthcheck**

Используется для проверки готовности эмулятора:

```yaml
xvfb:
    healthcheck:
      test: ["CMD", "ls", "/tmp/.X11-unix/X99"]
      interval: 5s
      retries: 5
      start_period: 10s
      timeout: 2s
    mem_limit: 2g
    cpus: "1.5"

emulator:
    healthcheck:
      test: ["CMD", "adb", "shell", "getprop", "sys.boot_completed"]
      interval: 10s
      retries: 10
      start_period: 60s
      timeout: 5s
    mem_limit: 8g
    cpus: "2.0"
```

3. **Скрипт запуска**

``run-emulator.sh`` управляет состоянием эмулятора:

```bash
for i in {1..10}; do
    if adb get-state >/adb-shared/adb.log 2>&1; then
        echo "ADB is responding."
        break
    fi
    echo "Waiting for adb to respond... (Attempt $i)"
    sleep 2
done

boot_completed=""
while [ "$boot_completed" != "1" ]; do
    boot_completed=$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')
    echo "Waiting for emulator to boot..."
    sleep 5
done
```

------------------------
## FAQ

1. **Почему эмулятор не запускается?**

Проверьте доступность ``/dev/kvm`` на хосте.

Убедитесь, что указаны правильные переменные среды (``DISPLAY``, ``ADB_SERVER_HOST)``.

2. **Можно ли запускать проект без Docker?**

Нет, проект ориентирован на контейнеризацию для обеспечения стабильной работы.

------------------------
## Контакты

**Автор:** Михаил

Если у вас есть вопросы или предложения, создайте issue в репозитории.
