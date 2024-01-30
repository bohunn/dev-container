FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl \
    openssl \
    jq \
    bash-completion \
    git \
    vim \
    openjdk-17-jdk \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Add a non-root user
RUN useradd -m devuser

# set bash shell
RUN chsh -s /bin/bash devuser

# Set environment variables
ENV HOME=/home/devuser
ENV CODE_SERVER_CONFIG_DIR=$HOME/.config/code-server
ENV CODE_SERVER_DATA_DIR=$HOME/.local/share/code-server

# Create necessary directories and adjust permissions
RUN mkdir -p $CODE_SERVER_CONFIG_DIR $CODE_SERVER_DATA_DIR \
    && chown -R devuser:root /home/devuser \
    && chmod -R 770 /home/devuser

# Set the user and working directory
USER devuser
WORKDIR /home/devuser

# Expose the code-server port
EXPOSE 8080

# Start code-server
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "--user-data-dir", "$CODE_SERVER_DATA_DIR", "--config", "$CODE_SERVER_CONFIG_DIR/config.yaml"]
