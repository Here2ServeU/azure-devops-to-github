#!/bin/bash

# Make sure to replace the following with your actual repo/org and runner token
REPO_URL="https://github.com/your-org/your-repo"
RUNNER_TOKEN="your-runner-token"

mkdir actions-runner && cd actions-runner

curl -o actions-runner-linux-x64-2.317.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz

tar xzf ./actions-runner-linux-x64-2.317.0.tar.gz

./config.sh --url "$REPO_URL" --token "$RUNNER_TOKEN" --unattended

./run.sh
