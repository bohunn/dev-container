FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    vim \
    openjdk-11-jdk \
    sudo

# Add a non-root user and give them sudo privileges
RUN useradd -m devuser && echo "devuser:devuser" | chpasswd && adduser devuser sudo
RUN echo 'devuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set the user and working directory
USER devuser
WORKDIR /home/devuser

ENV HOME=/home/devuser
ENV CODE_SERVER_CONFIG_DIR=$HOME/.config/code-server
ENV CODE_SERVER_DATA_DIR=$HOME/.local/share/code-server


# Install code-server (web-based VS Code)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Expose the code-server port
EXPOSE 8080

# Start code-server
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "--user-data-dir", "${CODE_SERVER_DATA_DIR}", "--config", "${CODE_SERVER_CONFIG_DIR}/config.yaml"]
