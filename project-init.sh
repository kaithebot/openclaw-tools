#!/bin/bash

# Project Initializer for OpenClaw
# Usage: ./project-init.sh <project-name> <type>
# Types: nextjs, react, vanilla

set -e

PROJECT_NAME=$1
PROJECT_TYPE=${2:-"nextjs"}

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: ./project-init.sh <project-name> [type]"
    echo "Types: nextjs, react, vanilla"
    exit 1
fi

echo "🚀 Creating new $PROJECT_TYPE project: $PROJECT_NAME"

# Determine directory
if [[ $PROJECT_NAME == storyverse* ]] || [[ $PROJECT_NAME == livre* ]]; then
    TARGET_DIR="/home/node/.openclaw/workspace/brands/$PROJECT_NAME"
else
    TARGET_DIR="/home/node/.openclaw/workspace/projects/$PROJECT_NAME"
fi

# Check if directory exists
if [ -d "$TARGET_DIR" ]; then
    echo "❌ Directory already exists: $TARGET_DIR"
    exit 1
fi

# Create project based on type
case $PROJECT_TYPE in
    "nextjs")
        echo "📦 Creating Next.js project..."
        npx create-next-app@latest "$TARGET_DIR" --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --no-turbopack --yes
        ;;
    "react")
        echo "⚛️  Creating React project..."
        npx create-react-app "$TARGET_DIR" --template typescript
        ;;
    "vanilla")
        echo "🌐 Creating vanilla HTML project..."
        mkdir -p "$TARGET_DIR"
        cat > "$TARGET_DIR/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: system-ui, sans-serif; padding: 2rem; }
    </style>
</head>
<body>
    <h1>Hello World</h1>
    <p>Project initialized successfully!</p>
</body>
</html>
EOF
        ;;
    *)
        echo "❌ Unknown project type: $PROJECT_TYPE"
        exit 1
        ;;
esac

echo "✅ Project created at: $TARGET_DIR"
echo "📝 Next steps:"
echo "   cd $TARGET_DIR"
echo "   git init"
echo "   git add ."
echo "   git commit -m 'Initial commit'"
