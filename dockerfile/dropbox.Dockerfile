
# Based on Ubuntu
FROM ubuntu:22.04

# Maintainer
LABEL maintainer "Alexander Graf <alex@otherguy.io>"

# Build arguments
ARG VCS_REF=master
ARG BUILD_DATE=""

# http://label-schema.org/rc1/
LABEL org.label-schema.schema-version "1.0"
LABEL org.label-schema.name           "Dropbox"
LABEL org.label-schema.build-date     "${BUILD_DATE}"
LABEL org.label-schema.description    "Standalone Dropbox client"
LABEL org.label-schema.vcs-url        "https://github.com/otherguy/docker-dropbox"
LABEL org.label-schema.vcs-ref        "${VCS_REF}"

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
RUN mkdir -p /opt/dropbox /opt/dropbox/.dropbox /opt/dropbox/Dropbox \
 && useradd --home-dir /opt/dropbox --comment "Dropbox Daemon Account" --user-group --shell /usr/sbin/nologin dropbox \
 && chown -R dropbox:dropbox /opt/dropbox

# Set language
ENV LANG     "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"
ENV LC_ALL   "en_US.UTF-8"

# Generate locales
RUN sed --in-place '/en_US.UTF-8/s/^# //' /etc/locale.gen \
 && locale-gen

# Change working directory
WORKDIR /opt/dropbox/Dropbox

# Not really required for --net=host
EXPOSE 17500

# Download and extract Dropbox daemon
RUN wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Create volumes
VOLUME ["/opt/dropbox/.dropbox", "/opt/dropbox/Dropbox"]

# Install init script and dropbox command line wrapper
COPY ./run.sh /usr/local/bin/run.sh
CMD ["run.sh"]
