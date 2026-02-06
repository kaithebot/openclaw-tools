#!/bin/bash

# Quick Commit Helper
# Usage: ./quick-commit.sh "commit message"

MESSAGE=${1:-"Update $(date +%H:%M)"}

echo "📝 Quick commit with message: $MESSAGE"

git add .
git commit -m "$MESSAGE"
git push

echo "✅ Committed and pushed!"
