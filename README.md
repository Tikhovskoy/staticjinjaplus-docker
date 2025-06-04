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

## Как собрать Docker-образ

Чтобы собрать образ с нужной версией StaticJinjaPlus, укажите тег или ветку в аргументе `SJP_VERSION`.

### **Сборка стабильной версии (Python Slim):**

```bash
docker build -f Dockerfile.slim --build-arg SJP_VERSION=0.1.1 -t static-jinja-plus:0.1.1-slim .
````

```bash
docker build -f Dockerfile.slim --build-arg SJP_VERSION=main -t static-jinja-plus:develop-slim .
```

### **Сборка стабильной версии на базе Ubuntu:**

```bash
docker build -f Dockerfile --build-arg SJP_VERSION=0.1.1 -t static-jinja-plus:0.1.1 .
```

### **Сборка develop-версии на базе Ubuntu (ветка main):**

```bash
docker build -f Dockerfile --build-arg SJP_VERSION=main -t static-jinja-plus:develop .
```

---

## Сборка с git-хэшем docker-репозитория

**Перед сборкой рекомендуется получить git-хэш текущего состояния этого docker-репозитория и передать его как build-arg.**

```bash
GIT_HASH=$(git rev-parse --short HEAD)
docker build -f Dockerfile.slim --build-arg GIT_HASH=$GIT_HASH --build-arg SJP_VERSION=0.1.1 -t static-jinja-plus:0.1.1-slim-$GIT_HASH .
```

```bash
docker build -f Dockerfile --build-arg GIT_HASH=$GIT_HASH --build-arg SJP_VERSION=main -t static-jinja-plus:develop-$GIT_HASH .
```

---

## Как запустить контейнер

Пример запуска контейнера с CLI StaticJinjaPlus (help, генерация и т.д.):

```bash
docker run --rm static-jinja-plus:0.1.1-slim --help
docker run --rm static-jinja-plus:develop-slim --help
docker run --rm static-jinja-plus:0.1.1 --help
docker run --rm static-jinja-plus:develop --help
```

---

## Версионирование и переменная окружения GIT\_HASH

* Каждый Docker-образ собирается с передачей git-хэша текущего состояния docker-репозитория (`staticjinjaplus-docker`) в переменную окружения `GIT_HASH`.
* Это позволяет проверить, из какого именно коммита docker-репозитория был собран образ.

### Как посмотреть git-хэш внутри контейнера:

```bash
docker run --rm --entrypoint env static-jinja-plus:0.1.1-slim | grep GIT_HASH
```

или для вашего собственного тега:

```bash
docker run --rm --entrypoint env tikhovskoi/static-jinja-plus:slim-<git_hash> | grep GIT_HASH
```

---

## Как это работает

* Образ при сборке автоматически скачивает исходники StaticJinjaPlus из официального GitHub-репозитория по нужному тегу/версии.
* Нет необходимости обновлять этот репозиторий при выходе новых релизов StaticJinjaPlus — просто используйте новый тег.

---

## Важно

* Размер итогового образа зависит от выбранной базы: `slim` в несколько раз меньше стандартного.