# Use a base image, e.g., Ubuntu 22.04
FROM ubuntu:22.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y git curl libicu-dev build-essential

# Create a directory to store the runner
RUN mkdir /actions-runner
WORKDIR /actions-runner

# Download GitHub Runner software
ARG RUNNER_VERSION=2.316.1
#RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L github.com{RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
#curl -o actions-runner-linux-x64-2.329.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.329.0/actions-runner-linux-x64-2.329.0.tar.gz
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
RUN tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz


# Copy the startup script
COPY start.sh .

# Set the startup command
CMD ["./start.sh"]