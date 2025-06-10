
# Azure DevOps to GitHub Migration Toolkit

This project provides a complete toolkit to help you migrate your code, pipelines, and runners from Azure DevOps to GitHub.

---

## Features
- Migrate Git history from Azure DevOps
- Rebuild CI/CD using GitHub Actions
- Set up self-hosted GitHub runners on Azure using Terraform

---

## How to Use

### 1. Migrate Repositories
```bash
./scripts/migrate-repo.sh https://dev.azure.com/your-org/project/_git/repo https://github.com/your-org/repo
```

### 2. Configure GitHub Actions
Update `.github/workflows/sample-ci.yml` to match your project’s build steps.

### 3. Set Up Self-Hosted Runner (Optional)
```bash
./scripts/setup-runner.sh
```

Or use Terraform:
```bash
cd terraform
terraform init
terraform apply
```

---

## Outputs
- GitHub repositories with full Git history
- GitHub Actions pipelines for CI/CD
- Azure-hosted self-hosted runners provisioned via Terraform

---

## Notes
- Don’t forget to update secrets and tokens in GitHub Actions settings.
- For production use, replace hardcoded values with environment variables or secrets.

---

## Security
- Always rotate your GitHub runner tokens and SSH keys.
- Consider setting up runners in a secure, sandboxed environment.

