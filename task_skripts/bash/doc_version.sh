#!/bin/bash
# Script for version control of documentation
# Commits and pushes all changes in the LaTeX project

set -e

echo "Committing documentation changes..."

# Add all changes
git add .

# Commit with timestamp
git commit -m "Updated documentation and LaTeX files - $(date '+%Y-%m-%d %H:%M:%S')"

# Push to remote
git push origin main

echo "Changes successfully pushed!"
