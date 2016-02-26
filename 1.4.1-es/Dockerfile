FROM lyrasis/archivesspace:base
MAINTAINER Mark Cooper <mark.c.cooper@outlook.com>

ENV ARCHIVESSPACE_VERSION=1.4.1

ENV ARCHIVESSPACE_URL=http://13ac7.http.dal05.cdn.softlayer.net/aspace/archivesspace-v1.4.1.zip \
  ARCHIVESSPACE_DB_TYPE=demo \
  ARCHIVESSPACE_DB_HOST_TYPE=internal \
  ARCHIVESSPACE_DB_NAME=archivesspace \
  ARCHIVESSPACE_DB_USER=archivesspace \
  ARCHIVESSPACE_DB_PASS=archivesspace

RUN wget $ARCHIVESSPACE_URL
RUN unzip archivesspace-v$ARCHIVESSPACE_VERSION.zip
RUN wget http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.34/mysql-connector-java-5.1.34.jar

# FINALIZE SETUP
RUN rm -rf /archivesspace/plugins/*
RUN cp /mysql-connector-java-5.1.34.jar /archivesspace/lib/
ADD setup.sh /setup.sh
RUN chmod u+x /*.sh
ADD launcher_rc.rb /archivesspace/launcher_rc.rb

EXPOSE 8080 8081 8089 8090

CMD ["/setup.sh"]
