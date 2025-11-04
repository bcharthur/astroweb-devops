#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 ISSUE_KEY ENV_NAME STATUS_KEY" >&2
  exit 1
fi

ISSUE_KEY="$1"     # ex : ASTRO-123
ENV_NAME="$2"      # dev / recette / prod (info)
STATUS="$3"        # ex : DEV_DEPLOYE

CONF="/opt/devops-bootstrap/config/jira.yaml"

JIRA_URL=$(yq '.url' "$CONF")
JIRA_USER=$(yq '.user' "$CONF")
JIRA_TOKEN=$(yq '.token' "$CONF")
TRANSITION_ID=$(yq ".transitions.$STATUS" "$CONF")

if [ -z "$TRANSITION_ID" ] || [ "$TRANSITION_ID" == "null" ]; then
  echo "[!] Transition '$STATUS' non configurée dans jira.yaml"
  exit 0
fi

curl -sS -u "$JIRA_USER:$JIRA_TOKEN"   -H "Content-Type: application/json"   -X POST   --data "{"transition": {"id": "$TRANSITION_ID"}}"   "$JIRA_URL/rest/api/2/issue/$ISSUE_KEY/transitions" >/dev/null

echo "[+] Jira : issue $ISSUE_KEY -> transition $STATUS ($ENV_NAME)"
