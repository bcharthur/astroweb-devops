#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="/opt/devops"
JENKINS_DIR="$BASE_DIR/jenkins"

mkdir -p "$JENKINS_DIR"
cd "$JENKINS_DIR"

if [ -f docker-compose.yml ]; then
  echo "[+] Jenkins : docker-compose déjà présent."
else
  echo "[+] Jenkins : création docker-compose.yml..."
  cat > docker-compose.yml <<'EOF'
version: "3.8"

services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    user: root
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins_home:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker
    restart: unless-stopped

volumes:
  jenkins_home:
EOF
fi

echo "[+] (Re)start Jenkins..."
docker-compose down || true
docker-compose up -d
