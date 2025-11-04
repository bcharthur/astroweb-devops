#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  echo "[!] Lance main.sh en root (dans le conteneur) !" >&2
  exit 1
fi

BASE_DIR="/opt/devops"
mkdir -p "$BASE_DIR"

echo "[+] Bootstrapping astroweb DevOps..."

./scripts/docker.sh
./scripts/git.sh
./scripts/jenkins.sh
./scripts/jira.sh

echo ""
echo "======================================="
echo " Jenkins : http://<IP_HOST>:8080"
echo " Jira    : http://<IP_HOST>:8085"
echo "======================================="
