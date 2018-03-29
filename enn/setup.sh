#!/bin/bash

# goto script dir
cd "$(dirname "$0")"

echo "== Cloning Nano Node Monitor"
git clone https://github.com/nanotools/nanoNodeMonitor.git /opt/nanoNodeMonitor

echo "== Starting Docker containers"
sudo docker-compose up -d

echo "== Opening Nano Node Port"
sudo ufw allow 7075