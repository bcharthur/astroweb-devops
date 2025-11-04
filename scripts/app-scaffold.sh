#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 APP_NAME" >&2
  exit 1
fi

APP_NAME="$1"
BASE_DIR="/opt/devops"
SRC_DIR="/opt/devops-bootstrap/config/apps/demo-app"

APP_DIR="$BASE_DIR/apps/$APP_NAME"

if [ -d "$APP_DIR" ]; then
  echo "[+] L'app '$APP_NAME' existe déjà dans $APP_DIR, rien à faire."
  exit 0
fi

echo "[+] Scaffold de l'app '$APP_NAME' à partir de demo-app"
mkdir -p "$APP_DIR"/{dev,recette,prod}

cp "$SRC_DIR/docker-compose.dev.yml" "$APP_DIR/dev/docker-compose.yml"
cp "$SRC_DIR/docker-compose.recette.yml" "$APP_DIR/recette/docker-compose.yml"
cp "$SRC_DIR/docker-compose.prod.yml" "$APP_DIR/prod/docker-compose.yml"

echo "[+] App '$APP_NAME' créée dans $APP_DIR"
