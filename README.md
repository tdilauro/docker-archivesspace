Docker ArchivesSpace
====================

Run ArchivesSpace in Docker.

**Quickstart**

```
./run.sh
```

**Update images**

To update images from the Docker registry:

```
docker pull mysql
docker pull markcooper/archivesspace
```

**Running**

```
# background mode
docker run --name archivesspace -d \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  markcooper/archivesspace

# foreground mode
docker run --name archivesspace -i -t \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  markcooper/archivesspace

# foreground mode and access container
docker run --name archivesspace -i -t \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  markcooper/archivesspace /bin/bash
```

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
docker run --name archivesspace -i -t \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  -e ARCHIVESSPACE_DB_TYPE=mysql \
  --link mysql:db \
  markcooper/archivesspace
```

To run with an `external` MySQL instance (i.e. not using `--link` to edit `config.rb`):

```
# use an external (unlinked) mysql server and mount config, plugins
docker run --name archivesspace -d \
  --net=host \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  -e ARCHIVESSPACE_DB_HOST_TYPE=external \
  -v $(pwd)/config:/archivesspace/config \
  -v $(pwd)/plugins:/archivesspace/plugins \
  markcooper/archivesspace
```

The above example assumes that `$(pwd)/config/config.rb` exists. When `ARCHIVESSPACE_DB_HOST_TYPE=external` and the config volume mount is omitted ArchivesSpace will run with default settings (i.e. `demo` database).

**Local build**

```
docker build -t archivesspace:latest .
```

---