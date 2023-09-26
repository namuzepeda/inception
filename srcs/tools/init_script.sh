#!/bin/bash

if command -v docker &> /dev/null; then
    echo "Docker is already instaled..."
else
    echo "Docker installing..."
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
fi

if command -v docker-compose &> /dev/null; then
    echo "Docker-compose is already instaled..."
else
    echo "Docker-compose installing..."
    sudo apt-get install -y docker-compose; \
fi





