# StaticJinjaPlus Docker

Здесь только инструменты (Dockerfile и инструкции), которые позволяют собрать Docker-образ любой версии StaticJinjaPlus напрямую из [репозитория](https://github.com/Tikhovskoy/StaticJinjaPlus).

---

## Возможности

* Сборка Docker-образа StaticJinjaPlus любой версии, без скачивания исходников вручную.
* Поддержка разных базовых образов: стандартный (`python:3.12`) и минималистичный (`python:3.12-slim`).
* Лёгкая публикация своих образов на DockerHub или локальное использование.
* Можно мгновенно получить последнюю версию StaticJinjaPlus при её появлении.

---

## Структура репозитория

```
staticjinjaplus-docker/
├── Dockerfile           # Для стандартного (ubuntu-based) образа
├── Dockerfile.slim      # Для минимального slim-образа
└── README.md            # Инструкция по использованию
```

---

##  Как собрать Docker-образ

Чтобы собрать образ с нужной версией StaticJinjaPlus, укажите тег в аргументе `SJP_VERSION`.

---

### **Сборка стабильной версии (Python Slim):**

```bash
docker build -f Dockerfile.slim --build-arg SJP_VERSION=0.1.1 -t static-jinja-plus:0.1.1-slim .
```

### **Сборка develop-версии (из ветки main, Python Slim):**

```bash
docker build -f Dockerfile.develop-slim -t static-jinja-plus:develop-slim .
```

### **Сборка стабильной версии на базе Ubuntu (через python:3.12):**

```bash
docker build -f Dockerfile --build-arg SJP_VERSION=0.1.1 -t static-jinja-plus:0.1.1 .
```

### **Сборка develop-версии на базе Ubuntu (через python:3.12):**

```bash
docker build -f Dockerfile.develop -t static-jinja-plus:develop .
```

---

## Как запустить контейнер

Пример запуска контейнера с CLI StaticJinjaPlus (help, генерация и т.д.):

```bash
docker run --rm -it static-jinja-plus:0.1.1-slim --help
docker run --rm -it static-jinja-plus:develop-slim --help
docker run --rm -it static-jinja-plus:0.1.1 --help
docker run --rm -it static-jinja-plus:develop --help
```

## Как это работает

* Образ при сборке автоматически скачивает исходники StaticJinjaPlus из официального GitHub-репозитория по нужному тегу/версии.
* Нет необходимости обновлять этот репозиторий при выходе новых релизов StaticJinjaPlus — просто используйте новый тег.

---

## Важно

* Размер итогового образа зависит от выбранной базы: `slim` в несколько раз меньше стандартного.
