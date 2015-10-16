FROM ubuntu:trusty
MAINTAINER Mark Cooper <mark.c.cooper@outlook.com>

COPY locale /etc/default/locale
RUN locale-gen en_US.UTF-8 && \
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8

ENV ARCHIVESSPACE_VERSION=1.4.1

ENV ARCHIVESSPACE_URL=https://github.com/archivesspace/archivesspace/releases/download/v1.4.1/archivesspace-v1.4.1.zip \
  ARCHIVESSPACE_DB_TYPE=demo \
  ARCHIVESSPACE_DB_HOST_TYPE=internal \
  ARCHIVESSPACE_DB_NAME=archivesspace \
  ARCHIVESSPACE_DB_USER=archivesspace \
  ARCHIVESSPACE_DB_PASS=archivesspace

# ADD MULTIVERSE FOR JASPER MS FONTS
RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse\n\
deb-src http://us.archive.ubuntu.com/ubuntu/ trusty multiverse\n\
deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse\n\
deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse\n'\
>> /etc/apt/sources.list

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

RUN wget $ARCHIVESSPACE_URL
RUN unzip archivesspace-v$ARCHIVESSPACE_VERSION.zip
RUN wget http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.34/mysql-connector-java-5.1.34.jar

# FINALIZE SETUP
RUN rm -rf /archivesspace/plugins/*
RUN cp /mysql-connector-java-5.1.34.jar /archivesspace/lib/
ADD setup.sh /setup.sh
RUN chmod u+x /*.sh

EXPOSE 8080 8081 8089 8090

CMD ["/setup.sh"]
