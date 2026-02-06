#!/bin/bash

# Workspace Status Checker
# Shows overview of all projects

echo "📊 WORKSPACE STATUS OVERVIEW"
echo "============================"
echo ""

echo "🗂️  Brands Directory:"
for dir in /home/node/.openclaw/workspace/brands/*/; do
    if [ -d "$dir/.git" ]; then
        name=$(basename "$dir")
        commits=$(cd "$dir" && git rev-list --count HEAD 2>/dev/null || echo "0")
        echo "  ✓ $name ($commits commits)"
    fi
done

echo ""
echo "📁 Projects Directory:"
for dir in /home/node/.openclaw/workspace/projects/*/; do
    if [ -d "$dir" ]; then
        name=$(basename "$dir")
        if [ -d "$dir/.git" ]; then
            commits=$(cd "$dir" && git rev-list --count HEAD 2>/dev/null || echo "0")
            echo "  ✓ $name ($commits commits)"
        else
            echo "  ○ $name (no git)"
        fi
    fi
done

echo ""
echo "🔧 Tools Available:"
ls -1 /home/node/.openclaw/workspace/tools/*.sh 2>/dev/null | while read tool; do
    name=$(basename "$tool")
    echo "  ⚡ $name"
done

echo ""
echo "✅ Status check complete!"
