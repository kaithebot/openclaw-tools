# OpenClaw Tools

Utility scripts for streamlined development workflow.

## Available Tools

### 🚀 auto-deploy.sh
Automated deployment script for GitHub Pages.
```bash
./auto-deploy.sh <project-name>
```

### 📦 project-init.sh
Initialize new projects with templates.
```bash
./project-init.sh <project-name> [nextjs|react|vanilla]
```

### ⚡ quick-commit.sh
Fast git commit and push.
```bash
./quick-commit.sh "commit message"
```

### 📊 workspace-status.sh
Overview of all workspace projects.
```bash
./workspace-status.sh
```

## Setup

Make scripts executable:
```bash
chmod +x *.sh
```

Add to PATH (optional):
```bash
export PATH="$PATH:/home/node/.openclaw/workspace/tools"
```

## Created
2026-02-06 - OpenClaw Automation Toolkit
