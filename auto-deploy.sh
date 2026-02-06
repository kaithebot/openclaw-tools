#!/bin/bash

# Auto Deploy Script for OpenClaw Projects
# Usage: ./auto-deploy.sh [project-name]

set -e

PROJECT_NAME=${1:-""}
if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: ./auto-deploy.sh <project-name>"
    echo "Example: ./auto-deploy.sh storyverse-hub"
    exit 1
fi

echo "🚀 Starting deployment for: $PROJECT_NAME"

# Find project directory
if [ -d "/home/node/.openclaw/workspace/brands/$PROJECT_NAME" ]; then
    PROJECT_DIR="/home/node/.openclaw/workspace/brands/$PROJECT_NAME"
elif [ -d "/home/node/.openclaw/workspace/projects/$PROJECT_NAME" ]; then
    PROJECT_DIR="/home/node/.openclaw/workspace/projects/$PROJECT_NAME"
else
    echo "❌ Project not found: $PROJECT_NAME"
    exit 1
fi

cd "$PROJECT_DIR"
echo "📁 Project directory: $PROJECT_DIR"

# Check if it's a Next.js project
if [ -f "next.config.ts" ] || [ -f "next.config.js" ]; then
    echo "📦 Building Next.js project..."
    npm run build
    
    # Move dist to docs for GitHub Pages
    if [ -d "dist" ]; then
        echo "📂 Moving dist to docs..."
        rm -rf docs
        mv dist docs
    fi
fi

# Git operations
echo "📝 Committing changes..."
git add .
git commit -m "Auto-deploy: $(date '+%Y-%m-%d %H:%M')" || echo "No changes to commit"

echo "⬆️  Pushing to GitHub..."
git push origin main || git push origin master

echo "✅ Deployment complete for $PROJECT_NAME!"
echo "🌐 Site will be live in 2-3 minutes"
