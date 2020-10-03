FROM alpine:latest

ENV PACKETVER=20200401

WORKDIR /server

RUN apk update \
  && apk add --no-cache netcat-openbsd make linux-headers gcc g++ mariadb-dev zlib-dev pcre-dev libressl-dev pcre libstdc++ nano dos2unix mysql-client bind-tools

COPY . .

RUN ./configure --enable-packetver=${PACKETVER} --enable-vip=yes \
  && make clean \
  && make server \
  && chmod a+x login-server && chmod a+x char-server && chmod a+x map-server \
  && apk del git make linux-headers gcc g++ mariadb-dev zlib-dev pcre-dev libressl-dev
