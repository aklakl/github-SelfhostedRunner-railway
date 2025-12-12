# Self-Hosted GitHub Runner on Railway

This repository contains the necessary Docker configuration to deploy a self-hosted GitHub Actions Runner on [Railway](https://railway.app/).

It builds an Ubuntu-based runner that automatically registers itself to your GitHub repository upon startup and unregisters (if handled gracefully) or is replaced upon redeployment.

## Project Structure

* **Dockerfile**: Sets up the environment (Ubuntu 22.04), installs dependencies (git, curl, etc.), and downloads the GitHub Actions Runner binary.
* **start.sh**: The entrypoint script. It grabs the configuration from environment variables, registers the runner with GitHub, and starts the listener process.

## Prerequisites

* A GitHub repository.
* A Railway account.

## Environment Variables

To make the runner work, you must define the following Environment Variables in your Railway project settings:

| Variable | Description | Required |
| :--- | :--- | :--- |
| `RUNNER_REPO_URL` | The full URL of the GitHub repository you want to link. <br>Example: `https://github.com/your-username/your-repo` | **Yes** |
| `RUNNER_TOKEN` | The temporary registration token from GitHub. <br>Go to **Settings** > **Actions** > **Runners** > **New self-hosted runner** to generate this token. | **Yes** |
| `RAILWAY_HOSTNAME` | Automatically provided by Railway. Used as the Runner's name to identify the specific instance. | No (Auto-set) |

> **Note:** The `start.sh` script uses the `--replace` flag. This ensures that if a container restarts with the same name, the old offline runner registration is overwritten by the new one.

## Deployment Guide

1.  **Push Code**: Push the `Dockerfile` and `start.sh` to your repository.
2.  **Create Service**: Open Railway and create a new service from your repository.
3.  **Set Variables**: Go to the **Variables** tab in Railway and add `RUNNER_REPO_URL` and `RUNNER_TOKEN`.
4.  **Deploy**: Railway will build the Docker image and start the container.
5.  **Verify**: Check your GitHub Repository **Settings** > **Actions** > **Runners**. You should see a new runner listed as "Idle" (green).

## Local Development (Optional)

To build and run this locally:

```bash
# 1. Build the image
docker build -t my-runner .

# 2. Run the container (Replace values with your actual data)
docker run -e RUNNER_REPO_URL="[https://github.com/user/repo](https://github.com/user/repo)" \
           -e RUNNER_TOKEN="YOUR_TOKEN_HERE" \
           -e RAILWAY_HOSTNAME="local-runner" \
           my-runner