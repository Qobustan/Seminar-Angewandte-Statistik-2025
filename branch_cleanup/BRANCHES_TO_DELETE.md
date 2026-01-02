# Obsolete Branches to Delete

This document lists all obsolete branches that should be deleted from the repository.

## Branch Deletion Summary

**Total branches:** 25
**To keep:** 3 (main + 2 active PR branches)
**To delete:** 22

## Branches to Keep

1. `main` - Main branch
2. `copilot/link-local-wiki-to-github` - Open PR #25
3. `copilot/delete-obsolete-branches` - Current PR #24

## Obsolete Branches to Delete

### Historical Feature Branches (7 branches)
These appear to be old feature branches with German names that are no longer needed:

1. `Einen-Fork-für-eine-potentielle-Vorlage-in-der-Zukunft-(soll-nicht-gemerged-werden)`
2. `Fertige,-nächtliche-Präsentationsversion`
3. `Jetzt-auch-mit-kompilierendem-erstem-Beispiel!`
4. `Mit-endgültigen-Tests`
5. `Mit-vollständig-korrektem-Readme`
6. `Nun-auch-mit-guter-Testabdeckung`
7. `Verbesserte-Vorlage-(mit-abgeschwächtem-.gitignore)`

### Completed Copilot PR Branches (15 branches)
These branches were created by Copilot for previous PRs that have been merged or closed:

1. `copilot/add-missing-batch-scripts`
2. `copilot/add-repo-wiki-files`
3. `copilot/compare-non-pr-branches`
4. `copilot/fix-generate-pdf-script`
5. `copilot/fix-generate-pdf-script-again`
6. `copilot/fix-github-actions-versions`
7. `copilot/fix-latex-formula-errors`
8. `copilot/improve-error-handling-perl-scripts`
9. `copilot/improve-shell-scripts-error-handling`
10. `copilot/refactor-script-files`
11. `copilot/update-readme`
12. `copilot/update-readme-again`
13. `copilot/update-readme-another-one`
14. `copilot/update-readme-documentation`
15. `copilot/update-readme-with-new-structure`
16. `copilot/update-readme-yet-again`

## How to Delete These Branches

You can delete these branches using the GitHub web interface or via the command line:

### Option 1: Using GitHub Web Interface
1. Go to https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/branches
2. Find each branch listed above
3. Click the trash icon to delete each branch

### Option 2: Using Git Command Line
Run the cleanup script provided: `./scripts/delete-obsolete-branches.sh`

Or manually delete branches one by one:
```bash
git push origin --delete <branch-name>
```

### Option 3: Using GitHub CLI
```bash
gh api -X DELETE /repos/Qobustan/Seminar-Angewandte-Statistik-2025/git/refs/heads/<branch-name>
```

## Notes

- These branches have been identified as obsolete because they either represent completed work or old feature branches that are no longer active.
- Before deleting, ensure that any important work has been merged into main or documented elsewhere.
- The branch with German name "Einen-Fork-für-eine-potentielle-Vorlage-in-der-Zukunft-(soll-nicht-gemerged-werden)" explicitly states it should not be merged, suggesting it may be a template or reference branch. Consider if this should be preserved as a tag instead.
