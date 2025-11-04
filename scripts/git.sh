#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="/opt/devops"
REPOS_DIR="$BASE_DIR/repos"
CONFIG="/opt/devops-bootstrap/config/git.yaml"

mkdir -p "$REPOS_DIR"

REPO_URL=$(yq '.repoUrl' "$CONFIG")

# Si GITHUB_TOKEN est défini, on l'injecte dans l'URL HTTPS pour les repos privés
RAW_URL="$REPO_URL"
if [ -n "${GITHUB_TOKEN:-}" ]; then
  # transforme https://github.com/... en https://USER:TOKEN@github.com/...
  RAW_URL="${RAW_URL/https:\/\//https://${GITHUB_USER:-x}:${GITHUB_TOKEN}@}"
fi

echo "[+] Git : sync du repo $RAW_URL"

REPO_NAME=$(basename "$REPO_URL" .git)
TARGET="$REPOS_DIR/$REPO_NAME"

if [ -d "$TARGET/.git" ]; then
  echo "  -> Repo déjà cloné, on fait un pull..."
  git -C "$TARGET" fetch --all
  git -C "$TARGET" pull --ff-only origin
else
  echo "  -> Clone initial..."
  git clone "$RAW_URL" "$TARGET"
fi
