# GitHub Web Interface Branch Deletion Guide

Since automated deletion requires GitHub credentials that may not be available, you can easily delete obsolete branches through the GitHub web interface.

## Step-by-Step Instructions

### Method 1: Using the Branches Page (Recommended)

1. **Navigate to the Branches Page**
   - Go to: https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/branches
   - Or click on the "branches" link on the main repository page

2. **Delete Each Obsolete Branch**
   - Find each branch listed in `BRANCHES_TO_DELETE.md`
   - Click the red trash can icon (🗑️) next to the branch name
   - The branch will be deleted immediately (no confirmation dialog)

3. **Branches to Delete (22 total)**

   **Historical Feature Branches (7):**
   - [ ] `Einen-Fork-für-eine-potentielle-Vorlage-in-der-Zukunft-(soll-nicht-gemerged-werden)`
   - [ ] `Fertige,-nächtliche-Präsentationsversion`
   - [ ] `Jetzt-auch-mit-kompilierendem-erstem-Beispiel!`
   - [ ] `Mit-endgültigen-Tests`
   - [ ] `Mit-vollständig-korrektem-Readme`
   - [ ] `Nun-auch-mit-guter-Testabdeckung`
   - [ ] `Verbesserte-Vorlage-(mit-abgeschwächtem-.gitignore)`

   **Completed Copilot PR Branches (15):**
   - [ ] `copilot/add-missing-batch-scripts`
   - [ ] `copilot/add-repo-wiki-files`
   - [ ] `copilot/compare-non-pr-branches`
   - [ ] `copilot/fix-generate-pdf-script`
   - [ ] `copilot/fix-generate-pdf-script-again`
   - [ ] `copilot/fix-github-actions-versions`
   - [ ] `copilot/fix-latex-formula-errors`
   - [ ] `copilot/improve-error-handling-perl-scripts`
   - [ ] `copilot/improve-shell-scripts-error-handling`
   - [ ] `copilot/refactor-script-files`
   - [ ] `copilot/update-readme`
   - [ ] `copilot/update-readme-again`
   - [ ] `copilot/update-readme-another-one`
   - [ ] `copilot/update-readme-documentation`
   - [ ] `copilot/update-readme-with-new-structure`
   - [ ] `copilot/update-readme-yet-again`

### Method 2: Using GitHub CLI (if installed)

If you have GitHub CLI (`gh`) installed and authenticated:

```bash
# Delete a single branch
gh api -X DELETE /repos/Qobustan/Seminar-Angewandte-Statistik-2025/git/refs/heads/BRANCH_NAME

# Or use the provided scripts
./scripts/delete-obsolete-branches.sh
```

### Method 3: Using Git Command Line

If you have write access to the repository:

```bash
# Delete a single remote branch
git push origin --delete BRANCH_NAME

# Example:
git push origin --delete copilot/add-missing-batch-scripts
```

### Important Notes

1. **Branches to Keep**: Do NOT delete these branches:
   - `main` - Main branch
   - `copilot/link-local-wiki-to-github` - Active PR #25
   - `copilot/delete-obsolete-branches` - Current PR #24

2. **Branch with Special Note**: The branch `Einen-Fork-für-eine-potentielle-Vorlage-in-der-Zukunft-(soll-nicht-gemerged-werden)` has a German name that translates to "A fork for a potential template in the future (should not be merged)". Consider if this should be preserved as a tag instead of deleted.

3. **Restoration**: Deleted branches can be restored within a short time frame if needed. If you accidentally delete a branch, you can restore it from the branches page by clicking "Restore" next to the deleted branch.

4. **Protected Branches**: If a branch is protected, you won't be able to delete it through the web interface. You'll need to modify the branch protection rules first.

## Verification

After deleting all branches:
1. Visit: https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/branches
2. Verify that only the following branches remain:
   - `main`
   - `copilot/link-local-wiki-to-github` (if PR #25 is still open)
   - `copilot/delete-obsolete-branches` (if PR #24 is still open)

## Tips for Faster Deletion

- Use keyboard shortcuts: After clicking delete, press Tab to move to the next delete button
- Sort branches by "Last updated" to see which ones are oldest
- You can use the search box at the top of the branches page to filter branches

## After Cleanup

Once all obsolete branches are deleted, you may want to:
1. Update this guide to mark all branches as deleted
2. Close this PR (if applicable)
3. Consider setting up a branch cleanup policy for future PRs
