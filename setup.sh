#!/bin/bash

if [[ "$ARCHIVESSPACE_DB_HOST_TYPE" != "external" ]]; then
  # assume docker link to mysql and edit config.rb
  cat /dev/null > /archivesspace/config/config.rb

  if [[ "$ARCHIVESSPACE_DB_TYPE" == "mysql" ]]; then
    echo "AppConfig[:db_url] = 'jdbc:mysql://$DB_PORT_3306_TCP_ADDR:3306/$ARCHIVESSPACE_DB_NAME?user=$ARCHIVESSPACE_DB_USER&password=$ARCHIVESSPACE_DB_PASS&useUnicode=true&characterEncoding=UTF-8'" \
      >> /archivesspace/config/config.rb
  fi

  for PLUGIN in /archivesspace/plugins/*; do
    [[ -d $PLUGIN ]] && echo "AppConfig[:plugins] << '${PLUGIN##*/}'" >> /archivesspace/config/config.rb
  done
fi

/archivesspace/scripts/setup-database.sh
exec /archivesspace/archivesspace.sh
