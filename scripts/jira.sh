#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="/opt/devops"
JIRA_DIR="$BASE_DIR/jira"

mkdir -p "$JIRA_DIR"
cd "$JIRA_DIR"

if [ -f docker-compose.yml ]; then
  echo "[+] Jira : docker-compose déjà présent."
else
  echo "[+] Jira : création docker-compose.yml..."
  cat > docker-compose.yml <<'EOF'
version: "3.8"

services:
  jira:
    image: atlassian/jira-software:9.15.0
    container_name: jira
    ports:
      - "8085:8080"
    volumes:
      - jira_home:/var/atlassian/application-data/jira
    environment:
      - ATL_JDBC_URL=
      - ATL_JDBC_USER=
      - ATL_JDBC_PASSWORD=
      - ATL_DB_TYPE=h2
    restart: unless-stopped

volumes:
  jira_home:
EOF
fi

echo "[+] (Re)start Jira..."
docker-compose down || true
docker-compose up -d
