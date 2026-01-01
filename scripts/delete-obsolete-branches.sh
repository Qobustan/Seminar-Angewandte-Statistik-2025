#!/bin/bash

# Script to delete obsolete branches from the repository
# This script will delete branches that are no longer needed
# List verified as of: 2026-01-01

set -e

# Repository configuration
REPO_OWNER="Qobustan"
REPO_NAME="Seminar-Angewandte-Statistik-2025"
REPO_FULL="${REPO_OWNER}/${REPO_NAME}"

echo "=================================="
echo "Obsolete Branch Cleanup Script"
echo "=================================="
echo ""
echo "This script will delete 22 obsolete branches from the repository."
echo "The following branches will be KEPT:"
echo "  - main"
echo "  - copilot/link-local-wiki-to-github (Open PR #25)"
echo "  - copilot/delete-obsolete-branches (Current PR #24)"
echo ""

# Function to delete a branch
delete_branch() {
    local branch_name="$1"
    echo "Deleting branch: $branch_name"
    if gh api -X DELETE "/repos/${REPO_FULL}/git/refs/heads/$branch_name" 2>/dev/null; then
        echo "  ✓ Successfully deleted: $branch_name"
    else
        echo "  ✗ Failed to delete: $branch_name (may not exist or insufficient permissions)"
    fi
}

# Prompt for confirmation
read -p "Do you want to proceed with deleting these branches? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "Operation cancelled."
    exit 0
fi

echo ""
echo "Starting branch deletion..."
echo ""

# Historical feature branches (German names)
echo "Deleting historical feature branches..."
delete_branch "Einen-Fork-für-eine-potentielle-Vorlage-in-der-Zukunft-(soll-nicht-gemerged-werden)"
delete_branch "Fertige,-nächtliche-Präsentationsversion"
delete_branch "Jetzt-auch-mit-kompilierendem-erstem-Beispiel!"
delete_branch "Mit-endgültigen-Tests"
delete_branch "Mit-vollständig-korrektem-Readme"
delete_branch "Nun-auch-mit-guter-Testabdeckung"
delete_branch "Verbesserte-Vorlage-(mit-abgeschwächtem-.gitignore)"

echo ""
echo "Deleting completed Copilot PR branches..."
delete_branch "copilot/add-missing-batch-scripts"
delete_branch "copilot/add-repo-wiki-files"
delete_branch "copilot/compare-non-pr-branches"
delete_branch "copilot/fix-generate-pdf-script"
delete_branch "copilot/fix-generate-pdf-script-again"
delete_branch "copilot/fix-github-actions-versions"
delete_branch "copilot/fix-latex-formula-errors"
delete_branch "copilot/improve-error-handling-perl-scripts"
delete_branch "copilot/improve-shell-scripts-error-handling"
delete_branch "copilot/refactor-script-files"
delete_branch "copilot/update-readme"
delete_branch "copilot/update-readme-again"
delete_branch "copilot/update-readme-another-one"
delete_branch "copilot/update-readme-documentation"
delete_branch "copilot/update-readme-with-new-structure"
delete_branch "copilot/update-readme-yet-again"

echo ""
echo "=================================="
echo "Branch cleanup completed!"
echo "=================================="
echo ""
echo "To verify the cleanup, visit:"
echo "https://github.com/${REPO_FULL}/branches"
