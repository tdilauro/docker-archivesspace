FROM ubuntu:trusty
MAINTAINER Mark Cooper <mark.c.cooper@outlook.com>

ENV ARCHIVESSPACE_VERSION=1.3.0-1

ENV ARCHIVESSPACE_URL=http://13ac7.http.dal05.cdn.softlayer.net/aspace/archivesspace-v$ARCHIVESSPACE_VERSION.zip \
  ARCHIVESSPACE_DB_TYPE=demo \
  ARCHIVESSPACE_DB_HOST_TYPE=internal \
  ARCHIVESSPACE_DB_NAME=archivesspace \
  ARCHIVESSPACE_DB_USER=archivesspace \
  ARCHIVESSPACE_DB_PASS=archivesspace

RUN apt-get -y install --no-install-recommends software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
  mysql-client \
  openjdk-8-jre-headless \
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
