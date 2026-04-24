#!/bin/bash

set -euo pipefail
# Colors
GREEN="\033[0;32m"
NC="\033[0m"

echo -e "${GREEN}=== Starting installation of DevOps tools ===${NC}"

# 1. Install Docker
if ! command -v docker &> /dev/null
then
    echo -e "${GREEN}Installing Docker...${NC}"
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg

    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" |
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker "$USER"

else
    echo -e "${GREEN}Docker already installed.${NC}"
fi

# 2. Install Docker Compose
if ! docker compose version &> /dev/null
then
    echo -e "${GREEN}Docker Compose plugin is not detected.${NC}"
else
    echo -e "${GREEN}Docker Compose already available as plugin.${NC}"
fi

# 3. Install Python 3.9+
if ! command -v python3 &> /dev/null
then
    echo -e "${GREEN}Installing Python...${NC}"
    sudo apt update
    sudo apt install -y python3 python3-pip python3-venv
else
    echo -e "${GREEN}Python already installed.${NC}"
fi


# 4. Install Django
if ! python3 -m django --version &> /dev/null
then
    echo -e "${GREEN}Installing Django via pip3...${NC}"
    pip3 install django
else
    echo -e "${GREEN}Django already installed.${NC}"
fi

echo -e "${GREEN}=== Installation complete! ===${NC}"
