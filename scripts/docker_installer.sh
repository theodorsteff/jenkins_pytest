#!/usr/bin/env bash
set -euo pipefail

# Helper to install Docker (if needed), enable Docker service and add the current and jenkins users to docker group

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found — installing..."
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg lsb-release apt-transport-https
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
else
  echo "Docker already installed: $(docker --version)"
fi

echo "Enabling docker service..."
sudo systemctl enable --now docker

echo "Adding $USER to docker group (may require logout/login)..."
sudo usermod -aG docker "$USER" || true

echo "Give jenkins user access to docker"
sudo usermod -aG docker jenkins || true
sudo systemctl restart jenkins