#!/bin/sh
#
# Start the `cdl-nginx` container used throughout the workshop.
# Override the host port with CDL_NGINX_PORT if 8080 is already taken.

PORT="${CDL_NGINX_PORT:-8080}"

docker pull nginx:latest

if ! docker run -d --restart always --name cdl-nginx -p "$PORT":80 nginx:latest; then
    # Docker leaves the container behind in the "Created" state when the
    # port bind fails; remove it so a retry is not blocked by the name.
    docker rm -f cdl-nginx > /dev/null 2>&1

    echo "" 1>&2
    echo "Could not start the cdl-nginx container." 1>&2
    echo "If the message above says port $PORT is already allocated, something" 1>&2
    echo "else on your machine is using it. Find out what with:" 1>&2
    echo "" 1>&2
    echo "    ss -ltnp | grep :$PORT" 1>&2
    echo "" 1>&2
    echo "Then either stop it, or pick another port and use that port instead" 1>&2
    echo "of 8080 for the rest of the workshop:" 1>&2
    echo "" 1>&2
    echo "    CDL_NGINX_PORT=8090 ./reset-all.sh" 1>&2
    exit 1
fi

echo "cdl-nginx is serving on http://localhost:$PORT"
