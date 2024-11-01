# Docker Workshop

This is a practical workshop on using [Docker](https://www.docker.com/) for developing and deploying applications.

First of all, fork [this repository](https://github.com/rosedu/workshop-docker):

```console
git clone https://github.com/rosedu/workshop-docker
cd workshop-docker/
```

And let's get going! 🚀

## Create a DockerHub Account

Sign up for a [DockerHub](https://hub.docker.com/) account.
We will use it for exercises below.

## Remote VM Access

We are using a remote virtual machine on the NCIT cluster.
For that, follow the steps:

1. Connect to `fep.grid.pub.ro`:

   ```console
   ssh <your_upb_username>@fep.grid.pub.ro
   ```

1. Use instructions from instructors to connect to your virtual machine.

1. You will use the `student` user.
   The `student` user is able to run Docker on the virtual machine.
   The user also has full access to the system via `sudo`.

## Inspect Docker Instances

Let's start with inspecting the Docker installation and instances on the virtual machine.

Follow the steps below:

1. See available `docker` commands:

   ```console
   docker help
   ```

1. Check the `docker` version:

   ```console
   docker version
   ```

1. See information about the `docker` information:

   ```console
   docker info
   ```
1. Find out the currently running Docker containers:

   ```console
   docker ps
   ```

   You will the Docker containers that are currently running, namely an Nginx container:

   ```text
   CONTAINER ID   IMAGE          COMMAND                  CREATED       STATUS          PORTS                                     NAMES
   fbfe1d0b5870   nginx:latest   "/docker-entrypoint.…"   6 hours ago   Up 38 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   cdl-nginx
   ```

1. Find out all containers, including those that are stopped:

   ```console
   docker ps -a
   ```

   A new container, named `ctf-piece_of_pie` is now visible:

   ```text
   CONTAINER ID   IMAGE              COMMAND                  CREATED          STATUS                        PORTS                                     NAMES
   16a526c7c94c   ctf-piece_of_pie   "/usr/local/bin/run.…"   24 minutes ago   Exited (137) 51 seconds ago                                             ctf-piece_of_pie
   fbfe1d0b5870   nginx:latest       "/docker-entrypoint.…"   6 hours ago      Up 40 seconds                 0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   cdl-nginx
   ```

1. Find out port-related information to the containers:

   ```console
   docker ports
   ```

   You can see the port forwarding:

   ```text
   80/tcp -> 0.0.0.0:8080
   80/tcp -> [::]:8080
   ```

   You can check the current install by querying the server:

   ```console
   curl localhost:8080
   ```

   You will see the default HTML page of Nginx.

1. Get detailed information about the Docker instances, either started or stopped:

   ```console
   docker inspect cdl-nginx
   docker inspect ctf-piece_of_pie
   ```

1. Find out of the runtime logging information of the container:

   ```console
   docker logs cdl-nginx
   docker logs ctf-piece_of_pie
   ```

1. Find out runtime statistics and resource consumption of the running Nginx containers:

   ```console
   docker stats cdl-nginx
   ```

1. Find out the processes of a running Nginx container:

   ```console
   docker top cdl-nginx
   ```

### Do It Yourself



## Interact with Docker Instances

Let's now do actual interaction with Docker container instances.
Such as starting and stopping containers, copying files to / from containers, getting a shell inside containers etc.

Follow the steps below:

   ```console
   docker stop
   ```
   ```console
   docker kill
   ```
   ```console
   docker start
   ```
   ```console
   docker exec
   ```
   ```console
   docker cp
   ```

## Docker Images

   ```console
   docker image ls
   ```
   ```console
   docker image inspect
   ```

## Images and Containers

   ```console
   docker create
   ```
   ```console
   docker rm
   ```
   ```console
   docker run
   ```

## Getting Images

   ```console
   docker search
   ```
   ```console
   docker pull
   ```

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
