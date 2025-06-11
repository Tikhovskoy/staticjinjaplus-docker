FROM python:3.12

ARG SJP_VERSION=main
ARG ZIP_CHECKSUM
ARG GIT_HASH=unknown

ENV SJP_VERSION=${SJP_VERSION}
ENV GIT_HASH=${GIT_HASH}

WORKDIR /tmp

ADD --checksum=${ZIP_CHECKSUM} https://github.com/Tikhovskoy/StaticJinjaPlus/archive/${SJP_VERSION}.zip /tmp/source.zip

RUN apt update && apt install -y unzip && \
    unzip /tmp/source.zip && \
    cd StaticJinjaPlus-* && \
    pip install . && \
    cd .. && rm -rf /tmp/*

WORKDIR /app
ENTRYPOINT ["staticjinja"]
