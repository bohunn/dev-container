FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    vim \
    openjdk-11-jdk

# Install code-server (web-based VS Code)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Add a non-root user
RUN useradd -m devuser
USER devuser
WORKDIR /home/devuser

# Expose the code-server port
EXPOSE 8080

# Start code-server
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
