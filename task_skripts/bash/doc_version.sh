#!/bin/bash
# Script for version control of documentation
# Commits and pushes all changes in the LaTeX project

set -e

echo "Committing documentation changes..."

# Add all changes
git add .

# Check if there are changes to commit
if git diff --cached --quiet; then
    echo "No changes to commit."
    exit 0
fi

# Commit with timestamp
git commit -m "Updated documentation and LaTeX files - $(date '+%Y-%m-%d %H:%M:%S')"

# Push to remote
git push origin main

echo "Changes successfully pushed!"
