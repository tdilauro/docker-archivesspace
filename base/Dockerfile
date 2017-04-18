FROM ubuntu:xenial
MAINTAINER Mark Cooper <mark.c.cooper@outlook.com>

# https://hub.docker.com/_/ubuntu/
ENV LANG C.UTF-8

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
  git \
  mysql-client \
  openjdk-8-jdk \
  openjdk-8-jre-headless \
  wget \
  unzip && \
  rm -rf /var/lib/apt/lists/*
