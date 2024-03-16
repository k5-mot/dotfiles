#!/usr/bin/env bash

if ! command -v apt > /dev/null 2>&1; then
    exit 0
fi


### Docker or Podman
container_tool="podman"

if [ "$container_tool" = "docker" ]; then
    ### Install Docker
    ### https://docs.docker.com/engine/install/ubuntu/

    # Uninstall old versions
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
        sudo apt remove $pkg;
    done

    # Add Docker's official GPG key
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg --batch --yes
    chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update

    # Install latest versions
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Verify that the Docker Engine installation is successful
    sudo docker run hello-world

elif [ "$container_tool" = "podman" ]; then
    ### Install Podman
    ### https://podman.io/docs/installation

    # Uninstall Docker
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
        sudo apt remove $pkg;
    done
    for pkg in docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; do
        sudo apt remove -y $pkg;
    done

    # Install Podman
    sudo apt update
    sudo apt install -y podman

    # Install podman-compose
    if command -v python &> /dev/null; then
        python3 -m pip install podman-compose
    fi

fi
