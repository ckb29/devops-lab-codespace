FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apt-transport-https ca-certificates curl gnupg lsb-release jq git build-essential

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
 https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
 | tee /etc/apt/sources.list.d/docker.list > /dev/null \
 && apt-get update && apt-get install -y docker-ce-cli docker-compose-plugin

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
 && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install kind
RUN curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64 \
 && chmod +x /usr/local/bin/kind

# Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
