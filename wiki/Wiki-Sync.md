# Wiki Sync Documentation

## Overview

This repository maintains its wiki documentation in the `wiki/` directory within the main repository. These files are automatically synchronized to the [GitHub Wiki](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki) through a GitHub Actions workflow.

## How It Works

### Automated Synchronization

The `.github/workflows/publish-wiki.yml` workflow automatically syncs the local `wiki/` directory to the GitHub Wiki whenever:

1. **Automatic Trigger**: Changes to files in the `wiki/` directory are pushed to the `main` or `master` branch
2. **Manual Trigger**: The workflow is manually triggered via the GitHub Actions interface

### Workflow Process

1. The workflow checks out the repository
2. Uses the `SwiftDocOrg/github-wiki-publish-action` (pinned to a specific commit SHA) to publish wiki content
3. Copies all markdown files from the `wiki/` directory to the GitHub Wiki repository
4. The GitHub Wiki is immediately updated and accessible online

**Note**: The workflow uses a pinned commit SHA for the action to avoid firewall-blocked API calls and ensure security and reproducibility.

## Editing Wiki Content

### For Contributors

To edit wiki content:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git
   cd Seminar-Angewandte-Statistik-2025
   ```

2. **Edit files in the `wiki/` directory:**
   ```bash
   # Edit any wiki file
   nano wiki/Getting-Started.md
   ```

3. **Commit and push changes:**
   ```bash
   git add wiki/
   git commit -m "Update wiki documentation"
   git push origin main
   ```

4. **Automated sync:**
   - The GitHub Actions workflow will automatically run
   - Wiki changes will be visible on the GitHub Wiki within a few minutes

### Creating New Wiki Pages

To create a new wiki page:

1. Create a new `.md` file in the `wiki/` directory
2. Use the naming convention: `Page-Title.md` (with hyphens, capital first letters)
3. Add content using standard Markdown format
4. Link to the page from other wiki pages or the `Home.md` page
5. Commit and push to trigger automatic sync

### File Naming Convention

- Use hyphens (`-`) to separate words in filenames
- Capitalize the first letter of each word
- Use `.md` extension
- Examples: `Getting-Started.md`, `CI-CD-Workflows.md`, `Project-Structure.md`

## Available Wiki Pages

The following pages are currently available:

- **[Home](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Home)** - Wiki homepage and navigation
- **[Getting Started](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Getting-Started)** - Quick start guide
- **[Building PDFs](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Building-PDFs)** - PDF compilation guide
- **[CI/CD Workflows](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/CI-CD-Workflows)** - GitHub Actions documentation
- **[Contributing](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Contributing)** - Contribution guidelines
- **[FAQ](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/FAQ)** - Frequently asked questions
- **[Troubleshooting](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Troubleshooting)** - Common issues and solutions
- **[Project Structure](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Project-Structure)** - Repository organization

## Benefits of This Approach

### Version Control
- Wiki content is version-controlled alongside code
- Full git history for all wiki changes
- Easy to review and revert changes

### Pull Request Workflow
- Wiki changes can be reviewed through pull requests
- Contributors can propose documentation improvements
- Maintains quality through code review process

### Consistency
- Single source of truth for documentation
- No manual synchronization needed
- Wiki always stays up-to-date with the main branch

### Backup
- Wiki content is backed up with the repository
- Easy to clone and maintain locally
- Part of the main repository backup strategy

## Troubleshooting

### Sync Not Working

If the wiki sync workflow fails:

1. **Check workflow status:**
   - Go to the Actions tab in the GitHub repository
   - Look for the "Publish Wiki" workflow
   - Check error logs if the workflow failed

2. **Verify permissions:**
   - The workflow requires write permissions to the wiki
   - Check that the repository has wiki enabled
   - Ensure `GITHUB_TOKEN` has appropriate permissions

3. **Manual sync:**
   - You can manually trigger the workflow from the Actions tab
   - Click on "Publish Wiki" workflow
   - Click "Run workflow" button

### Wiki Not Enabled

If the GitHub Wiki is not enabled for the repository:

1. Go to repository Settings
2. Scroll to "Features" section
3. Enable "Wikis" checkbox
4. The sync workflow will work on the next push

## Additional Resources

- [GitHub Wiki Documentation](https://docs.github.com/en/communities/documenting-your-project-with-wikis)
- [Markdown Guide](https://www.markdownguide.org/)
- [SwiftDocOrg/github-wiki-publish-action](https://github.com/SwiftDocOrg/github-wiki-publish-action)

---

[← Back to README](../README.md)
