#!/bin/bash

AS_CONF_FILE=/archivesspace/config/config.rb
AS_DOCKER_DB="AppConfig[:db_url] = 'jdbc:mysql://$DB_PORT_3306_TCP_ADDR:3306/$ARCHIVESSPACE_DB_NAME?user=$ARCHIVESSPACE_DB_USER&password=$ARCHIVESSPACE_DB_PASS&useUnicode=true&characterEncoding=UTF-8'"

if [[ "$ARCHIVESSPACE_DB_HOST_TYPE" != "external" ]]; then
  cat /dev/null > $AS_CONF_FILE

  if [[ "$ARCHIVESSPACE_DB_TYPE" == "mysql" ]]; then
    echo $AS_DOCKER_DB >> $AS_CONF_FILE
  fi

  for PLUGIN in /archivesspace/plugins/*; do
    [[ -d $PLUGIN ]] && echo "AppConfig[:plugins] << '${PLUGIN##*/}'" >> /archivesspace/config/config.rb
  done
else
  if [[ "$ARCHIVESSPACE_DB_TYPE" == "mysql" ]]; then
    if ! grep -Fq "jdbc:mysql://" $AS_CONF_FILE; then
      "DB_TYPE is mysql but JDBC url is not present."
      exit 1
    fi
  fi
fi

/archivesspace/scripts/setup-database.sh
exec /archivesspace/archivesspace.sh