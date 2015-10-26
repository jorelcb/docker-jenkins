FROM jenkins:latest

USER root

# Ansible support
RUN apt-get update && apt-get install -y python-pip python-dev && rm -rf /var/lib/apt/lists/*

RUN pip install ansible markupsafe

# Docker support
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.8.2
ENV DOCKER_SHA256 97a3f5924b0b831a310efa8bf0a4c91956cd6387c4a8667d27e2b2dd3da67e4d

RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker \
    && echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
    && chmod +x /usr/local/bin/docker

# Docker-compose suport
ENV DOCKER_COMPOSE_VERSION 1.4.0

RUN curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m`" > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Default user
USER jenkins

