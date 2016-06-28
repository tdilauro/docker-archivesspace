#!/bin/bash

TASK=${1:-"selenium:staff"}
TASK_ARGS=${2:-""}
TASK_OPTS=${3:-"-Dcores=4 -Dgroups=1"}

/sbin/start-stop-daemon \
  --start \
  --quiet \
  --pidfile /tmp/custom_xvfb_99.pid \
  --make-pidfile \
  --background \
  --exec /usr/bin/Xvfb -- :99 -ac -screen 0 2560x1700x24

if [ "$ASPACE_NUKE" == true ]; then
  # start with a clean database, index and delete tmp files
  /archivesspace/build/run frontend:clean
  /archivesspace/build/run public:clean
  /archivesspace/build/run db:nuke
fi

exec /archivesspace/build/run $TASK $TASK_ARGS $TASK_OPTS
