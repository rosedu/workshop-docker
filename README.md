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

Install Docker Engine following the [tutorial](https://docs.docker.com/engine/install/).
We recommend that you install Docker inside of a Linux Virtual Machine if you're running on Windows so that you can take advantage of its CLI features.

Use either [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/install) or the Intro to Operating Systems [Virtual Machine](https://repository.grid.pub.ro/cs/uso/USO.ova) if you you with to run in a Linux VM.

Make sure to add your user to the `docker` group so you can run the docker commands without `sudo`.

## Dockerfile

Dockerfiles provide recipes for creating a container by writing a script which sets up the container environment.

[The following file](https://github.com/linux-kernel-labs/linux/blob/master/tools/labs/docker/kernel/Dockerfile) defines a Docker container.
Read the file and follow the rules which are defined in it.
We notice the following keywords:

* FROM - the base container on top of which the setup will be done;
* RUN - runs a setup command;
* WORKDIR - sets the container work directory to the specific path;
* USER - sets the running user to the specific username;
* ARG - defines an argument at build time;
* COPY - copies a file from the build directory to the container.

Inspect the following Dockerfiles and try to follow the commands being run and the keywords used:
* [uso-labs](https://github.com/systems-cs-pub-ro/uso-lab/blob/master/labs/03-user/lab-container/fizic/Dockerfile)
* [docker-setup](https://github.com/Sergiu121/uso-lab/blob/master/labs/09-task-admin/lab-container/dropbox/Dockerfile)

### Python Server

Go to the `python-server` directory and build the container using the following command:
```
docker build -t python-server:1.0 .
```

The command builds the container with the specification from the Dockerfile.
Add another line which installs the curl package.
Test the container functionality by connecting to it and running the `curl localhost:8080` command.

Change the base image to Debian and rebuild the container tagged with the `python-server-debian:1.0` tag.

Create a Makefiles which has the following rules:
* `build`: creates a new image using the Dockerfile;
* `start`: starts a container based on the `python-server` image named `python-workspace` in the background;
* `stop`: stops the `python-workspace` container;
* `connect`: connects to the container in an interactive shell.

### Assignment Checker

A common use case for using containers is platform-agnostic testing. The `assignment-checker` directory contains a bash scripts which runs tests on an application by running it and comparing its output with a reference.

Create a Docker image which is able to run this script, compile de application and run the tests.

## Volumes

While it makes sense to run Docker containers by themselves as services, all the data that they produce is ephemeral and will be deleted when the container is destroyed.

To provide an input to the containers and a permanent storage for them we use volumes.

Volumes are used to save outputs of files permanently. Start a container based on the image you can build and call `infinite-wrier`in the background using the following command:
```
docker run -d --name perpetual-writer -v perpetual-storage:/var/perpetual-storage -t perpetual-writer
```

Stop it and remove it.
Start a new container based on the same image using the same command.
Enter the container and check the content of the `/perpetual-storage/logs` file.

The files are still stored on disk but in the `/var/lib/docker` directory.
To find local mount point of the volume run the `docker volume inspect` command.
List the content of that directory.

Run the scripts in `TODO`.
Identify for each container what volume it is using and what is the path to that volume on disk.
There are three containers.

### Bind mounts

Bind volumes mount files or directories from the host to a path in the container.

We will be running the `nginx` container using content on our host system.
The command to do this from the repository root is:
```
TODO
```

The `TODO` directory is mounted to the `/var/www` directory. Change the above command to mount the `TODO` directory instead. See what has changed.

Add an additional mount point to the above command to mount the `TODO` file as the nginx configuration file fount at `TODO`.

#### Build Program With GCC13

An advantage of using containers is the fact that they offer a flexible environment for testing and building applications. Based on [this]() Dockerfile, create a Docker image which compiles an application based based on a Makefile located in the `/workdir` path.

The container must be able to compile applications using GCC13.

## Container Registries


Now that we have created a set of containers, we want to publish them so they are available to the world and to download on other systems.

To push the `python-container` image that we have built earlier, we will need to tag it so that it has an associated namespace as such:
```
docker tag python-container:1.0 <dockerhub-username>/python-container:1.0
```
Where `dockerhub-username` is your Dockerhub username.

To push the container you will use the `docker push command`:
```
docker push <dockerhub-username>/python-container:1.0
```

Tag the `assignment-checker` container and push it to Dockerhub.

### Using GitHub Container Registry

While using Dockerhub offers great visibility for projects and container images, it limits the number of pulls for images on a specific IP. To bypass this issue we will create a GitHub Container Registry (GHCR) account and login to it.

Follow the [GHCR tutorial](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry) to create a GHCR account.

Login to the account the same as you did with the Dockerhub account and tag the `assignment-checker` image to be pushed to GHCR.

## Advanced Applications

### Dokerfile stages

We have noticed that actions in Dockerfiles are split up into multiple RUN actions.
Compare the two Dockerfile examples found in the `simple-docker` and `staged-docker` directories.

Remove the install of `cowsay` from both of the Dockerfiles, rebuild the images, and notice which one is rebuilt the fastest.

### Docker image save

reference Compose;
no time to work on it

## GitHub Actions

Sample GitHub project written in C
Have action to build and test
