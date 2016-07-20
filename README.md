Docker ArchivesSpace
====================

[![](https://badge.imagelayers.io/lyrasis/archivesspace:latest.svg)](https://imagelayers.io/?images=lyrasis/archivesspace:latest 'Get your own badge on imagelayers.io')
[![Build Status](https://travis-ci.org/lyrasis/docker-archivesspace.svg?branch=master)](https://travis-ci.org/lyrasis/docker-archivesspace)

Run ArchivesSpace in Docker.

**Update images**

To update images from the Docker registry:

```
docker pull mysql
docker pull lyrasis/archivesspace # latest / source
docker pull lyrasis/archivesspace:1.4.1 # version
```

**With Demo database**

```
# background mode
docker run --name archivesspace -d \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  lyrasis/archivesspace

# foreground mode
docker run --name archivesspace -it \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  lyrasis/archivesspace

# foreground mode and access container
docker run --name archivesspace -it \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  lyrasis/archivesspace /bin/bash
```

To run a specific version use `lyrasis/archivesspace:1.4.2` (for example).

**With MySQL**

```
# pull and run the official mysql docker image
docker run -d \
  -p 3306:3306 \
  --name mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e MYSQL_DATABASE=archivesspace \
  -e MYSQL_USER=archivesspace \
  -e MYSQL_PASSWORD=archivesspace \
  mysql

# foreground mode
docker run --name archivesspace -it \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  -e ARCHIVESSPACE_DB_TYPE=mysql \
  --link mysql:db \
  lyrasis/archivesspace

# foreground with mounted configuration
docker run --name archivesspace -it \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  -e ARCHIVESSPACE_DB_TYPE=mysql \
  -v $(pwd)/config:/archivesspace/config \
  -v $(pwd)/plugins:/archivesspace/plugins \
  --link mysql:db \
  lyrasis/archivesspace
```

The latter example enables the use of a custom configuration file within the linked container. To set the `db_url` correctly in `config.rb` include this line:

```ruby
AppConfig[:db_url] = "jdbc:mysql://#{ENV['DB_PORT_3306_TCP_ADDR']}:3306/#{ENV['ARCHIVESSPACE_DB_NAME']}?user=#{ENV['ARCHIVESSPACE_DB_USER']}&password=#{ENV['ARCHIVESSPACE_DB_PASS']}&useUnicode=true&characterEncoding=UTF-8"
```

To run with an `external` MySQL instance (i.e. not using `--link` with `db`):

```
# use an external (unlinked) mysql server and mount config, plugins
docker run --name archivesspace -it \
  --net=host \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  -e ARCHIVESSPACE_DB_TYPE=mysql \
  -e ARCHIVESSPACE_DB_HOST_TYPE=external \
  -v $(pwd)/config:/archivesspace/config \
  -v $(pwd)/plugins:/archivesspace/plugins \
  lyrasis/archivesspace
```

The above example assumes that `$(pwd)/config/config.rb` exists.

**Local build**

From source:

```
docker build --no-cache=true -t archivesspace:latest latest/
docker run --name archivesspace -it \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  archivesspace:latest
```

From a release:

```
docker build -t archivesspace:1.4.2 1.4.2/
docker run --name archivesspace -it \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  archivesspace:1.4.2
```

---
