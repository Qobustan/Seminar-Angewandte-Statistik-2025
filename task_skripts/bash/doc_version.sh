#!/bin/bash
# ==============================================================================
#
#          FILE: doc_version.sh
#
#   DESCRIPTION: Script for version control of LaTeX documentation
#                Commits and pushes changes to LaTeX files and images
#
#       USAGE: ./doc_version.sh [commit_message] [-h|--help]
#
#       OPTIONS: commit_message - Optional custom commit message
#                -h, --help     - Show usage information
#
# ==============================================================================

set -euo pipefail

# Show help if requested
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    cat << EOF
Usage: $0 [commit_message]

Description:
    Commits and pushes changes to LaTeX documentation files.
    Prompts for confirmation before committing and pushing.

Arguments:
    commit_message    Optional custom commit message
                      (default: "Aktualisierte Dokumentation und LaTeX-Dateien")

Examples:
    $0
    $0 "Added new chapter on statistics"

EOF
    exit 0
fi

# Default commit message
DEFAULT_MESSAGE="Aktualisierte Dokumentation und LaTeX-Dateien"

# Use provided commit message or default
COMMIT_MESSAGE="${1:-$DEFAULT_MESSAGE}"

# Check if git is available
if ! command -v git &> /dev/null; then
    echo "Error: git command not found" >&2
    echo "Please install git to use this script" >&2
    exit 1
fi

# Check if we are in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository" >&2
    exit 1
fi

echo "Führe Git-Commit aus..."

# Check if there are any changes to commit
if git diff-index --quiet HEAD -- 2>/dev/null; then
    echo "Keine Änderungen zum Committen"
    exit 0
fi

# Show status
echo "Status der Änderungen:"
git status --short

echo ""
echo "Commit-Nachricht: \"$COMMIT_MESSAGE\""
echo ""

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
if ! git commit -m "$COMMIT_MESSAGE"; then
    echo "Fehler beim Committen. Bitte manuell überprüfen." >&2
    exit 1
fi

# Get current branch name
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "Pushing to branch: $CURRENT_BRANCH"

# Änderungen zum Git-Remote-Server pushen
if git push origin "$CURRENT_BRANCH"; then
    echo "Änderungen wurden erfolgreich gepusht!"
else
    echo "Fehler beim Pushen. Bitte manuell überprüfen." >&2
    exit 1
fi
