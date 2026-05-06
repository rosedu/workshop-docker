
# Based on Ubuntu
FROM ubuntu:22.04

# Maintainer
LABEL maintainer="Alexander Graf <alex@otherguy.io>"

# Build arguments
ARG VCS_REF=main
ARG VERSION=""
ARG BUILD_DATE=""

# http://label-schema.org/rc1/
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="Dropbox"
LABEL org.label-schema.version="${VERSION}"
LABEL org.label-schema.build-date="${BUILD_DATE}"
LABEL org.label-schema.description="Standalone Dropbox client"
LABEL org.label-schema.vcs-url="https://github.com/otherguy/docker-dropbox"
LABEL org.label-schema.vcs-ref="${VCS_REF}"

# Required to prevent warnings
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    libc6 \
    libstdc++6 \
    gosu \
    tzdata \
    python3 \
 && rm -rf /var/lib/apt/lists/*

# Create user and group
RUN mkdir -p /opt/dropbox \
 && useradd --home-dir /opt/dropbox --comment "Dropbox Daemon Account" --user-group --shell /usr/sbin/nologin dropbox \
 && chown -R dropbox:dropbox /opt/dropbox

# Set language
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

# Change working directory
WORKDIR /opt/dropbox

# Not really required for --net=host
EXPOSE 17500

# Download and extract Dropbox daemon
RUN wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Create volumes
VOLUME ["/opt/dropbox/.dropbox", "/opt/dropbox/Dropbox"]

# Install init script and dropbox command line wrapper
COPY ./run.sh /usr/local/bin/run.sh
CMD ["run.sh"]
