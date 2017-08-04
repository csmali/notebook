# DockerProjectNotes

Took notes from https://www.youtube.com/watch?v=Wyr8_tsjKlE

## Version

```
docker version
```

## Images

```
docker images
```

## Run Images

Run and save log
```
docker run hello-world
```

Start in deamon mode (background)
```
docker run -d hello-world
```

Run and delete logs
```
docker run --rm hello-world
```

Run ubuntu and command
```
docker run ubuntu ls -lrt /lib
```

Interactive terminal (shell)
```
docker run -it ubuntu /bin/bash
```

## List Images

List running images
```
docker ps
```

List old images
```
docker ps -a
```

## Remove  Images

Remove old image log starting with id 046
```
docker rm 046
```

List old images
```
docker rm $(docker ps -aq)
```

* [Docker Images](https://hub.docker.com)


## Pause | Stop | Kill Images

Pause container
```
docker pause 970
```

Unpause container
```
docker unpause 970
```

Kill container. If we start after killing container it starts in deamon mode.
```
docker kill 970
```

## Creating Image

Creating dockerfile
```
mkdir garbage
cd garbage
touch Dockerfile
gedit Dockerfile
```

Creating pingable ubuntu
```
FROM ubuntu

MAINTAINER my name myemail@myemail.com

RUN apt-get update

RUN apt-get install -y inetutils-ping

CMD ("ping","8.8.8.8")
```

Building pingable ubuntu (trailing dot means current folder)
```
docker build -t myname/newubuntuping .
```



Running pingable ubuntu 
```
docker run myname/newubuntuping .
```


## Creating Postgre Image

Creating Postgre with local version of it (not latest, e is env variable) 
```
docker run --name mynew-postgre -e POSTGRES_PASSWORD=secret postgres:9.4
```

Checking postgre (postgre port is not open so error occurs!)
```
telnet localhost 5432
```

Creating Postgre with PORT FORWARDING (correct usage)
```
docker run --name mynew-postgre -p 5432:5432 -e POSTGRES_PASSWORD=secret postgres:9.4
```

Docker ps output (after port forwarding)
```
from

5432/tcp

to

0.0.0.0:5432->5432/tcp
```

# TO DO

Planning to add more !
