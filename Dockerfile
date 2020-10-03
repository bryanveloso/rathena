FROM debian:9.4

ENV DEBIAN_FRONTEND=noninteractive
ENV PACKETVER=20200401

WORKDIR /server

RUN apt-get update && apt-get -y install \
  make \
  g++ \
  mysql-client \
  mysql-server \
  default-libmysqlclient-dev \
  zlib1g-dev \
  libpcre3-dev \
  git

COPY . .

RUN ./configure --enable-packetver=${PACKETVER} --enable-vip=yes \
  && make clean \
  && make server \
  && groupadd -g 999 appuser \
  && useradd -r -u 999 -g appuser appuser \
  && chmod a+x /server/wait.sh \
  && chown appuser /server

USER appuser
