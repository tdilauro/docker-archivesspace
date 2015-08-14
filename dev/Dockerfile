FROM java:8

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install supervisor
ADD supervisord-aspace.conf /etc/supervisor/conf.d/supervisord-aspace.conf

ENV ASPACE_DEMO false

CMD ["/usr/bin/supervisord", "-n"]