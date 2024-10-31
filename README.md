# Docker Workshop

This is a practical workshop on using [Docker](https://www.docker.com/) for developing and deploying applications.

First of all, fork [this repository](https://github.com/rosedu/workshop-docker):

```console
git clone https://github.com/rosedu/workshop-docker
cd workshop-docker/
```

And let's get going! 🚀

## Remote VM Access

get access to remote VM (in NCIT cluster)

## Inspect Docker Instances

docker help
docker version
docker info
docker ps
docker ps -a
docker ports
docker inspect
docker logs
docker stats
docker top

## Interact with Docker Instances

docker stop
docker kill
docker start
docker exec
docker cp

## Docker Images

docker image ls
docker image inspect

## Images and Containers

docker create
docker rm
docker run

## Getting Images

docker search
docker pull

## Installing Docker

Install Docker

Do post-install steps

## Dockerfile

### Python Server

build image from simple Dockerfile: a simple Python server: docker build

- build from a Python base image
- build from a Debian / Ubuntu base image
- build from a RedHat base image

Create container

Use `Makefile` with common rules

### Assignment Checker

TODO

## Volumes

docker run -v

### Build Program With GCC13

present input and collect output from volume

### Cross-Compile for AArch64

present input and collect output from volume

## Container Registries

Create account on DockerHub - push

Use ghcr.io

## GitHub Actions

Sample GitHub project written in C
Have action to build and test

## Advanced Stuff

behind the scenes look at `/var/lib/docker`

stages, overlay

docker save

reference Compose;
no time to work on it
