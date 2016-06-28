FROM ubuntu:trusty

ENV DISPLAY=:99.0

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get -y install firefox openjdk-7-jre-headless supervisor xvfb
ADD run.sh /run.sh
RUN chmod u+x /run.sh
ADD supervisord-aspace.conf /etc/supervisor/conf.d/supervisord-aspace.conf

ENV ASPACE_NUKE false
ENV ASPACE_DEMO false
ENV ASPACE_PUBLIC_DEV false

CMD ["/usr/bin/supervisord", "-n"]
