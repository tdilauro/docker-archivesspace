FROM ubuntu:trusty
MAINTAINER Mark Cooper <mark.c.cooper@outlook.com>

COPY locale /etc/default/locale
RUN locale-gen en_US.UTF-8 && \
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8

# ADD MULTIVERSE FOR JASPER MS FONTS
RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse\n\
deb-src http://us.archive.ubuntu.com/ubuntu/ trusty multiverse\n\
deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse\n\
deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse\n'\
>> /etc/apt/sources.list

# ACCEPT THE LICENSE
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

RUN apt-get -y install --no-install-recommends software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN echo msttcorefonts msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
  mysql-client \
  msttcorefonts \
  openjdk-8-jdk \
  wget \
  unzip && \
  rm -rf /var/lib/apt/lists/*
