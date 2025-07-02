#!/usr/bin/env bash

printf "\e[30;42;1m102_install-kubernetes.shE\e[0m\n"

### docker-compose
if ! command -v "docker-compose" &> /dev/null; then
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose -v
fi

### minikube
if ! command -v "minikube" &> /dev/null; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm -f minikube-linux-amd64
    minikube version
fi

### Kubectl
if ! command -v "kubectl" &> /dev/null; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv -f ./kubectl /usr/local/bin
    kubectl version
fi

### eksctl
if ! command -v "eksctl" &> /dev/null; then
    ARCH=amd64
    PLATFORM=$(uname -s)_$ARCH
    curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
    curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
    tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
    sudo mv /tmp/eksctl /usr/local/bin
    eksctl version
fi
