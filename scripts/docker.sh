#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="/opt/devops"
APPS_DIR="$BASE_DIR/apps"

echo "[+] Vérification Docker..."

if ! command -v docker >/dev/null 2>&1; then
  echo "  -> Installation de docker.io et docker-compose"
  apt-get update -y
  DEBIAN_FRONTEND=noninteractive apt-get install -y docker.io docker-compose
else
  echo "  -> Docker déjà présent, OK."
fi

mkdir -p "$APPS_DIR"

# Exemple : pré-scaffolder une app demo à partir des templates du repo
APP_NAME="demo-app"
if [ ! -d "$APPS_DIR/$APP_NAME" ]; then
  echo "[+] Scaffold de l'app '$APP_NAME' dans $APPS_DIR..."
  mkdir -p "$APPS_DIR/$APP_NAME"/{dev,recette,prod}
  cp /opt/devops-bootstrap/config/apps/$APP_NAME/docker-compose.dev.yml      "$APPS_DIR/$APP_NAME/dev/docker-compose.yml"
  cp /opt/devops-bootstrap/config/apps/$APP_NAME/docker-compose.recette.yml      "$APPS_DIR/$APP_NAME/recette/docker-compose.yml"
  cp /opt/devops-bootstrap/config/apps/$APP_NAME/docker-compose.prod.yml      "$APPS_DIR/$APP_NAME/prod/docker-compose.yml"
fi

echo "[+] Docker + arbo /opt/devops prêts."
