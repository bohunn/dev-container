FROM ubuntu:latest

# Install necessary packages and code-server
# ... (your previous installation commands)

# Add a non-root user and switch to it
RUN useradd -m devuser
USER devuser
WORKDIR /home/devuser

# Set environment variables
ENV HOME=/home/devuser
ENV CODE_SERVER_CONFIG_DIR=$HOME/.config/code-server
ENV CODE_SERVER_DATA_DIR=$HOME/.local/share/code-server

# Make sure the directories exist and are owned by devuser
RUN mkdir -p $CODE_SERVER_CONFIG_DIR $CODE_SERVER_DATA_DIR

# Expose the code-server port
EXPOSE 8080

# Start code-server
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "--user-data-dir", "$CODE_SERVER_DATA_DIR", "--config", "$CODE_SERVER_CONFIG_DIR/config.yaml"]
