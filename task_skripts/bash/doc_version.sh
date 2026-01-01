#!/bin/bash
# Script to commit and push documentation changes

set -euo pipefail

# Help function
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [COMMIT_MESSAGE]

Commit and push documentation and LaTeX file changes to the repository.

ARGUMENTS:
    COMMIT_MESSAGE  Optional custom commit message. If not provided,
                    uses default message "Update documentation and LaTeX files"

OPTIONS:
    -h, --help      Show this help message and exit

DESCRIPTION:
    This script stages all changes, commits them with a message, and pushes
    to the current branch. It will show the git status before committing and
    ask for confirmation before pushing.

REQUIREMENTS:
    - git must be installed
    - Must be run from within a git repository
    - Must have push access to the repository

EXAMPLES:
    $(basename "$0")
    $(basename "$0") "Update chapter 3"
    $(basename "$0") --help

EOF
}

# Parse command line arguments
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed or not in PATH"
    echo "Please install git to use this script"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    echo "Please run this script from within a git repository"
    exit 1
fi

# Get commit message from argument or use default
COMMIT_MESSAGE="${1:-Update documentation and LaTeX files}"

echo "=== Documentation Version Control ==="
echo ""
echo "Committing documentation changes..."
echo ""

# Show current status
echo "Current git status:"
git status --short

if [[ -z $(git status --porcelain) ]]; then
    echo ""
    echo "No changes to commit. Working tree is clean."
    exit 0
fi

echo ""
echo "Changes will be committed with message: \"$COMMIT_MESSAGE\""
echo ""

# Stage all changes
git add .

# Show what will be committed
echo "Files to be committed:"
git diff --cached --name-status

# Commit changes
echo ""
echo "Creating commit..."
git commit -m "$COMMIT_MESSAGE"

# Ask for confirmation before push
echo ""
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
read -p "Push changes to origin $CURRENT_BRANCH? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Pushing to origin $CURRENT_BRANCH..."
    git push origin "$CURRENT_BRANCH"
    echo ""
    echo "Changes pushed successfully!"
else
    echo "Push cancelled. Changes have been committed locally."
    echo "You can push manually later with: git push origin $CURRENT_BRANCH"
fi

echo ""
echo "=== Done ==="
