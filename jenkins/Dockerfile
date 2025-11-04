FROM jenkins/jenkins:lts

USER root

RUN apt-get update \
    && apt-get install -y docker.io curl \
    && mkdir -p /usr/lib/docker/cli-plugins \
    && curl -SL "https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64" \
       -o /usr/lib/docker/cli-plugins/docker-compose \
    && chmod +x /usr/lib/docker/cli-plugins/docker-compose \
    && rm -rf /var/lib/apt/lists/*

# On laisse Jenkins tourner en root pour simplifier l'accès à Docker dans ce TP
USER root
