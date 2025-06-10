#!/bin/bash

# Usage: ./migrate-repo.sh <azure_repo_url> <github_repo_url>

AZURE_REPO=$1
GITHUB_REPO=$2

if [[ -z "$AZURE_REPO" || -z "$GITHUB_REPO" ]]; then
  echo "Usage: $0 <azure_repo_url> <github_repo_url>"
  exit 1
fi

echo "Cloning from Azure DevOps..."
git clone --mirror "$AZURE_REPO" repo-mirror

cd repo-mirror || exit 1

echo "Pushing to GitHub..."
git push --mirror "$GITHUB_REPO"

cd ..
rm -rf repo-mirror

echo "Migration complete."
