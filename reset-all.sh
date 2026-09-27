#!/bin/sh

container_stop_and_remove()
{
    name="$1"

    # Check if container is running.
    if test "$(docker container inspect -f '{{.State.Running}}' "$name" 2> /dev/null)" = "true"; then
        # Stop container if it running.
        echo "Stopping container $name ... "
        docker stop "$name"
    fi

    # Check if container exists.
    docker container inspect "$name" > /dev/null 2>&1
    if test $? -eq 0; then
        # Remove container if it exists.
        echo "Removing container $name ... "
        docker rm "$name"
    fi
}

container_stop_and_remove "cdl-nginx"
container_stop_and_remove "ctf-piece_of_pie"
container_stop_and_remove "cdl-caddy"
container_stop_and_remove "cdl-debian-bash"

# Run from the directory this script lives in, so the relative paths below
# work no matter where it is invoked from.
cd "$(dirname "$0")" || exit 1

# Start Nginx container.
if ! ./vanilla-nginx/run-nginx-container.sh; then
    echo "reset-all.sh: failed to set up the Nginx container; stopping here." 1>&2
    exit 1
fi

# Start CTF container.
if ! (cd ctf/deploy && make run); then
    echo "reset-all.sh: failed to set up the CTF container; stopping here." 1>&2
    exit 1
fi

# Stop CTF container (for initial environment).
docker stop ctf-piece_of_pie

echo ""
echo "Environment ready: cdl-nginx is running, ctf-piece_of_pie is stopped."
