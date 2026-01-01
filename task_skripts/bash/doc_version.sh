#!/bin/bash
# ==============================================================================
#
#          FILE: doc_version.sh
#
#   DESCRIPTION: Script for version control of LaTeX documentation
#                Commits and pushes changes to LaTeX files and images
#
#       USAGE: ./doc_version.sh [commit_message]
#
#       OPTIONS: commit_message - Optional custom commit message
#
# ==============================================================================

set -euo pipefail

# Default commit message
DEFAULT_MESSAGE="Aktualisierte Dokumentation und LaTeX-Dateien"

# Use provided commit message or default
COMMIT_MESSAGE="${1:-$DEFAULT_MESSAGE}"

# Check if we are in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository" >&2
    exit 1
fi

echo "Führe Git-Commit aus..."

# Check if there are any changes to commit
if git diff-index --quiet HEAD --; then
    echo "Keine Änderungen zum Committen"
    exit 0
fi

# Show status
echo "Status der Änderungen:"
git status --short

# Ask for confirmation
read -p "Möchten Sie diese Änderungen committen und pushen? (j/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[JjYy]$ ]]; then
    echo "Abgebrochen"
    exit 0
fi

# Alle Änderungen zum Commit hinzufügen
git add .

# Commit mit einer Nachricht
git commit -m "$COMMIT_MESSAGE"

# Get current branch name
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Änderungen zum Git-Remote-Server pushen
if git push origin "$CURRENT_BRANCH"; then
    echo "Änderungen wurden erfolgreich gepusht!"
else
    echo "Fehler beim Pushen. Bitte manuell überprüfen." >&2
    exit 1
fi
