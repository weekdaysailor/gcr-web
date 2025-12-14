#!/usr/bin/env bash
set -euo pipefail
ROOT="/home/keith/gcr-sim/gcr-site"
SERVICE="hugo-gcr.service"

log(){ printf '[deploy] %s\n' "$1"; }

log "Stopping $SERVICE"
sudo systemctl stop "$SERVICE"

log "Pulling latest code"
cd "$ROOT"
git pull --ff-only origin main

log "Building site (hugo --minify)"
hugo --minify

log "Restarting $SERVICE"
sudo systemctl start "$SERVICE"

log "Deployment complete"
