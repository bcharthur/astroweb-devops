FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&     apt-get install -y --no-install-recommends       ca-certificates       curl       git       docker.io       docker-compose       jq       vim       nano       less       iproute2 &&     rm -rf /var/lib/apt/lists/*

# yq pour lire les YAML dans les scripts
RUN curl -L "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64"     -o /usr/local/bin/yq &&     chmod +x /usr/local/bin/yq

WORKDIR /opt/devops-bootstrap

COPY . .

RUN chmod +x main.sh scripts/*.sh

CMD ["./main.sh"]
