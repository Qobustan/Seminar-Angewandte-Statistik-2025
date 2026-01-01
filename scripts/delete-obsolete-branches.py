#!/usr/bin/env python3
"""
Script to delete obsolete branches from the Seminar-Angewandte-Statistik-2025 repository.

This script uses the GitHub API to delete branches that are no longer needed.
Requires: PyGithub (install with: pip install PyGithub)
"""

import os
import sys
import time
from typing import List

# Check if PyGithub is available
try:
    from github import Github, GithubException
except ImportError:
    print("Error: PyGithub is not installed.")
    print("Please install it with: pip install PyGithub")
    sys.exit(1)

# Repository details
REPO_OWNER = "Qobustan"
REPO_NAME = "Seminar-Angewandte-Statistik-2025"

# Branches to keep (main branch and active PRs)
BRANCHES_TO_KEEP = [
    "main",
    "copilot/link-local-wiki-to-github",  # PR #25
    "copilot/delete-obsolete-branches",   # PR #24
]

# Obsolete branches to delete
# List verified as of: 2026-01-01
# Note: This is a one-time cleanup script. Update this list if re-running later.
OBSOLETE_BRANCHES = [
    # Historical feature branches
    "Einen-Fork-für-eine-potentielle-Vorlage-in-der-Zukunft-(soll-nicht-gemerged-werden)",
    "Fertige,-nächtliche-Präsentationsversion",
    "Jetzt-auch-mit-kompilierendem-erstem-Beispiel!",
    "Mit-endgültigen-Tests",
    "Mit-vollständig-korrektem-Readme",
    "Nun-auch-mit-guter-Testabdeckung",
    "Verbesserte-Vorlage-(mit-abgeschwächtem-.gitignore)",
    
    # Completed Copilot PR branches
    "copilot/add-missing-batch-scripts",
    "copilot/add-repo-wiki-files",
    "copilot/compare-non-pr-branches",
    "copilot/fix-generate-pdf-script",
    "copilot/fix-generate-pdf-script-again",
    "copilot/fix-github-actions-versions",
    "copilot/fix-latex-formula-errors",
    "copilot/improve-error-handling-perl-scripts",
    "copilot/improve-shell-scripts-error-handling",
    "copilot/refactor-script-files",
    "copilot/update-readme",
    "copilot/update-readme-again",
    "copilot/update-readme-another-one",
    "copilot/update-readme-documentation",
    "copilot/update-readme-with-new-structure",
    "copilot/update-readme-yet-again",
]


def delete_branches(token: str, dry_run: bool = False) -> None:
    """
    Delete obsolete branches from the repository.
    
    Args:
        token: GitHub personal access token
        dry_run: If True, only print what would be deleted without actually deleting
    """
    print("=" * 60)
    print("Obsolete Branch Cleanup Script")
    print("=" * 60)
    print()
    
    # Initialize GitHub client
    g = Github(token)
    
    try:
        repo = g.get_repo(f"{REPO_OWNER}/{REPO_NAME}")
        print(f"Repository: {repo.full_name}")
        print()
        
        # Get all branches
        all_branches = [branch.name for branch in repo.get_branches()]
        print(f"Total branches in repository: {len(all_branches)}")
        print()
        
        # Display branches to keep
        print("Branches to KEEP:")
        for branch in BRANCHES_TO_KEEP:
            if branch in all_branches:
                print(f"  ✓ {branch}")
            else:
                print(f"  ⚠ {branch} (not found in repository)")
        print()
        
        # Display branches to delete
        print(f"Branches to DELETE: {len(OBSOLETE_BRANCHES)}")
        branches_to_delete = [b for b in OBSOLETE_BRANCHES if b in all_branches]
        branches_not_found = [b for b in OBSOLETE_BRANCHES if b not in all_branches]
        
        if branches_not_found:
            print()
            print("Branches already deleted or not found:")
            for branch in branches_not_found:
                print(f"  - {branch}")
        
        print()
        print(f"Branches that will be deleted: {len(branches_to_delete)}")
        for branch in branches_to_delete:
            print(f"  - {branch}")
        
        if dry_run:
            print()
            print("DRY RUN - No branches were actually deleted.")
            return
        
        # Confirm deletion
        print()
        response = input("Do you want to proceed with deleting these branches? (yes/no): ")
        if response.lower() != "yes":
            print("Operation cancelled.")
            return
        
        # Delete branches
        print()
        print("Deleting branches...")
        print()
        
        success_count = 0
        error_count = 0
        
        for branch_name in branches_to_delete:
            try:
                ref = repo.get_git_ref(f"heads/{branch_name}")
                ref.delete()
                print(f"  ✓ Deleted: {branch_name}")
                success_count += 1
                # Small delay to avoid hitting rate limits
                time.sleep(0.5)
            except GithubException as e:
                print(f"  ✗ Failed to delete {branch_name}: {e.data.get('message', str(e))}")
                error_count += 1
            except Exception as e:
                print(f"  ✗ Unexpected error deleting {branch_name}: {str(e)}")
                error_count += 1
        
        # Summary
        print()
        print("=" * 60)
        print("Cleanup Summary")
        print("=" * 60)
        print(f"Successfully deleted: {success_count}")
        print(f"Failed to delete: {error_count}")
        print()
        print("To verify the cleanup, visit:")
        print(f"https://github.com/{REPO_OWNER}/{REPO_NAME}/branches")
        
    except GithubException as e:
        print(f"Error accessing repository: {e.data.get('message', str(e))}")
        sys.exit(1)
    except Exception as e:
        print(f"Unexpected error: {str(e)}")
        sys.exit(1)


def main():
    """Main entry point for the script."""
    # Check for GitHub token
    token = os.environ.get("GITHUB_TOKEN")
    if not token:
        print("Error: GITHUB_TOKEN environment variable is not set.")
        print()
        print("Please set your GitHub personal access token:")
        print("  export GITHUB_TOKEN=your_token_here")
        print()
        print("To create a token, visit:")
        print("  https://github.com/settings/tokens")
        print("  Required scopes: repo (Full control of private repositories)")
        sys.exit(1)
    
    # Check for dry-run flag
    dry_run = "--dry-run" in sys.argv or "-n" in sys.argv
    
    if dry_run:
        print("Running in DRY RUN mode - no branches will be deleted.")
        print()
    
    delete_branches(token, dry_run)


if __name__ == "__main__":
    main()
