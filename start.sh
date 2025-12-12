#!/bin/bash

# start.sh is responsible for configuring and starting the runner

# Retrieve TOKEN and REPO_URL from Railway environment variables
TOKEN=$RUNNER_TOKEN
REPO_URL=$RUNNER_REPO_URL

if [ -z "$TOKEN" ] || [ -z "$REPO_URL" ]; then
  echo "Error: RUNNER_TOKEN and RUNNER_REPO_URL environment variables must be set."
  exit 1
fi

# Configure the runner, setting the name to Railway Hostname (retrieved from Railway env vars)
./config.sh --url "$REPO_URL" --token "$TOKEN" --name "$RAILWAY_HOSTNAME" --unattended --replace

# Start the runner
./run.sh