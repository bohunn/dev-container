FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    vim \
    openjdk-11-jdk \
    nodejs \
    npm

# Add a user for the development environment
RUN useradd -m devuser
USER devuser

# Set the working directory
WORKDIR /home/devuser
