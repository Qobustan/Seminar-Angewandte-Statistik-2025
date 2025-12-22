#!/bin/bash
# Script to commit and push documentation changes

set -e

echo "Committing documentation changes..."

git add .
git commit -m "Update documentation and LaTeX files"
git push origin main

echo "Changes pushed successfully!"
