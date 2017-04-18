#!/bin/bash

JDBC="jdbc:mysql://"

AS_CONF_FILE="/archivesspace/config/config.rb"
AS_DOCKER_DB="AppConfig[:db_url] = '${JDBC}$DB_PORT_3306_TCP_ADDR:3306/$ARCHIVESSPACE_DB_NAME?user=$ARCHIVESSPACE_DB_USER&password=$ARCHIVESSPACE_DB_PASS&useUnicode=true&characterEncoding=UTF-8'"

# append db url when mysql is linked if not set (i.e. via mounted `config.rb`)
if [[ "$ARCHIVESSPACE_DB_HOST_TYPE" == "internal" && "$ARCHIVESSPACE_DB_TYPE" == "mysql" ]]; then
  if ! grep -Fq $JDBC $AS_CONF_FILE; then
    echo $AS_DOCKER_DB >> $AS_CONF_FILE
  fi
fi

# check in all cases that db url "appears" correct when db type is mysql
if [[ "$ARCHIVESSPACE_DB_TYPE" == "mysql" ]]; then
  if ! grep -Fq $JDBC $AS_CONF_FILE; then
    echo "DB_TYPE is mysql but JDBC url is not present."
    exit 1
  fi
fi

/archivesspace/scripts/setup-database.sh
exec /archivesspace/archivesspace.sh