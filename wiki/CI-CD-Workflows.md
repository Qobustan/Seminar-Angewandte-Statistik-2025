# CI/CD Workflows

This repository uses GitHub Actions for continuous integration and deployment. This page documents all automated workflows.

## Overview

The project includes several automated workflows for:
- 📦 Building and publishing PDFs
- 📖 Publishing wiki documentation
- ✅ Code quality checks (linting, formatting)
- 🔤 Spell-checking
- 📚 BibTeX validation
- 🏷️ Automated labeling
- 🤖 Dependency management

## Workflows

### 1. Build and Publish PDFs

**File**: `.github/workflows/build-and-publish-pdfs.yml`

**Badge**: [![Build all LaTeX projects](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml)

#### Triggers

- Push to `main` branch
- Manual trigger (workflow_dispatch)

#### What It Does

1. **Setup Environment**
   - Installs minimal TeX Live
   - Installs required LaTeX packages:
     - pdflatex and core tools
     - German language support
     - Bibliography tools (biber)
     - Common LaTeX packages

2. **Build Documents**
   - Compiles `Ausarbeitung/Ausarbeitung.tex` → PDF
   - Compiles `Vortrag/Vortrag.tex` → PDF
   - Uses latexmk with PDFLaTeX
   - Handles multiple passes automatically

3. **Collect Artifacts**
   - Gathers generated PDFs
   - Prepares for deployment

4. **Publish to Branch**
   - Pushes PDFs to `pdfs` branch
   - Maintains history of builds
   - Accessible via GitHub web interface

#### Accessing Built PDFs

```bash
# Clone the pdfs branch
git clone -b pdfs https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git

# Or fetch specific PDF
curl -O https://raw.githubusercontent.com/Qobustan/Seminar-Angewandte-Statistik-2025/pdfs/Ausarbeitung.pdf
```

#### Customizing the Workflow

To add packages, edit the workflow file:

```yaml
- name: Install TeX Live packages
  run: |
    sudo apt-get update
    sudo apt-get install -y \
      texlive-latex-base \
      texlive-latex-extra \
      texlive-lang-german \
      biber \
      your-additional-package
```

### 2. Spell Check

**File**: `.github/workflows/spellcheck.yml`

#### Triggers

- Push to any branch
- Pull requests

#### What It Does

- Runs **cspell** (Code Spell Checker)
- Checks LaTeX files (`.tex`)
- Checks Markdown files (`.md`)
- Uses dictionary from `cspell.json`

#### Configuration

The spell-checker uses `cspell.json` for configuration:

```json
{
  "language": "en,de",
  "words": [
    "LaTeX",
    "BibTeX",
    "PDFLaTeX",
    // Add custom words here
  ],
  "ignorePatterns": [
    "\\\\cite\\{.*?\\}",
    "\\\\ref\\{.*?\\}"
  ]
}
```

#### Adding Words to Dictionary

Edit `cspell.json` and add words to the `words` array:

```json
{
  "words": [
    "newword",
    "customterm",
    "propernouns"
  ]
}
```

#### Ignoring False Positives

Use inline comments in LaTeX:

```latex
% cspell:disable-next-line
\newcommand{\specialterm}{...}

% cspell:ignore specialterm anotherterm
```

### 3. BibTeX Check

**File**: `.github/workflows/bibcheck.yml`

#### Triggers

- Push to any branch
- Pull requests

#### What It Does

- Validates BibTeX file syntax
- Checks for common errors:
  - Missing required fields
  - Duplicate keys
  - Invalid entry types
  - Malformed entries

#### Fixing BibTeX Errors

Common issues and solutions:

```bibtex
% Bad: Missing comma
@article{key
  title = {Title}
  author = {Author}
}

% Good: Proper syntax
@article{key,
  title = {Title},
  author = {Author}
}

% Bad: Duplicate key
@article{smith2020,
  ...
}
@article{smith2020,  % ERROR: Duplicate
  ...
}

% Good: Unique keys
@article{smith2020a,
  ...
}
@article{smith2020b,
  ...
}
```

### 4. Formatting Check

**File**: `.github/workflows/format.yml`

#### Triggers

- Push to any branch
- Pull requests

#### What It Does

- Checks code formatting consistency
- Validates indentation
- Ensures consistent line endings
- Checks for trailing whitespace

#### Configuration

Uses settings from `editorconfig.txt`:

```ini
[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
```

### 5. Linting

**File**: `.github/workflows/lint.yml`

#### Triggers

- Push to any branch
- Pull requests

#### What It Does

- Runs LaTeX linters (lacheck)
- Validates LaTeX syntax
- Checks for common LaTeX mistakes
- Provides suggestions for improvements

#### Common Lint Warnings

```latex
% Warning: Unescaped underscore
filename_test.txt

% Fix: Escape special characters
filename\_test.txt

% Warning: Hard-coded spacing
word \hspace{1cm} word

% Better: Use semantic spacing
word~word  % non-breaking space
```

### 6. Project Summary

**File**: `.github/workflows/summary.yml`

#### Triggers

- Scheduled (weekly)
- Manual trigger

#### What It Does

- Generates project statistics
- Counts lines of code
- Tracks document word counts
- Provides repository metrics

### 7. Stale Issue Management

**File**: `.github/workflows/stale.yml`

#### Triggers

- Scheduled (daily)

#### What It Does

- Marks inactive issues as stale (90 days)
- Marks inactive PRs as stale (60 days)
- Auto-closes stale items (30 days after marked)
- Adds "stale" label

#### Preventing Issues from Going Stale

Add a comment or label to keep issues active:

```
This is still relevant.
```

Or add the `pinned` label to exempt from stale checks.

### 8. Automated Labeling

**File**: `.github/workflows/label.yml`

**Configuration**: `.github/labeler.yml`

#### Triggers

- Pull requests

#### What It Does

- Automatically applies labels based on changed files
- Helps organize and categorize PRs

#### Label Rules

Configured in `.github/labeler.yml`:

```yaml
documentation:
  - '**/*.md'
  - 'wiki/**/*'

latex:
  - '**/*.tex'
  - '**/*.bib'

ci:
  - '.github/workflows/**'

scripts:
  - 'scripts/**'
  - '**/*.sh'
```

### 9. Dependabot

**File**: `.github/dependabot.yml`

#### What It Does

- Monitors dependencies for security updates
- Creates automated PRs for updates
- Supports GitHub Actions dependencies

#### Configuration

```yaml
version: 2
updates:
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
```

### 10. Setup Perl

**File**: `.github/workflows/setup_perl.yml`

#### Purpose

- Installs Perl dependencies
- Sets up Perl environment for scripts
- Used by other workflows requiring Perl tools

### 11. Publish Wiki

**File**: `.github/workflows/publish-wiki.yml`

#### Triggers

- Push to `main` or `master` branch (when wiki files change)
- Manual trigger (workflow_dispatch)

#### What It Does

1. **Checkout Repository**
   - Checks out the repository with wiki content

2. **Publish to GitHub Wiki**
   - Syncs markdown files from `wiki/` directory to the repository's GitHub Wiki
   - Uses `github-wiki-publish-action` pinned to a specific commit SHA
   - Avoids firewall-blocked API calls by using commit SHA instead of version tags

#### Why Commit SHA?

This workflow uses a pinned commit SHA for the `github-wiki-publish-action` instead of a version tag (e.g., `@v1`). This approach:
- Prevents firewall-blocked API calls to GitHub releases/tags endpoints
- Ensures reproducible builds with a specific action version
- Improves security by using an immutable reference

#### Accessing the Wiki

Visit the repository's [Wiki tab](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki) to view the published documentation.

## Workflow Status

View the status of all workflows:

1. Go to the [Actions tab](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions)
2. Select a workflow to view runs
3. Click on a specific run to see detailed logs

## Troubleshooting Workflow Failures

### Build Failures

**Check logs**:
1. Go to Actions → Build all LaTeX projects
2. Click the failed run
3. Expand the failed step

**Common causes**:
- Missing LaTeX packages → Update workflow to install them
- LaTeX compilation errors → Fix in the `.tex` files
- Bibliography errors → Check `.bib` files

### Spell Check Failures

**View errors**:
```bash
# Run locally
npx cspell "**/*.tex" "**/*.md"
```

**Fix**:
- Add legitimate words to `cspell.json`
- Fix actual typos
- Use inline ignore comments for edge cases

### BibTeX Check Failures

**Validate locally**:
```bash
biber --tool --validate-datamodel Ausarbeitung/Ausarbeitung.bib
```

**Fix**:
- Correct syntax errors
- Ensure all required fields are present
- Remove duplicate keys

## Manual Workflow Triggers

Some workflows can be triggered manually:

1. Go to Actions tab
2. Select the workflow
3. Click "Run workflow"
4. Select branch and parameters
5. Click "Run workflow" button

## Workflow Best Practices

### For Contributors

1. **Run checks locally** before pushing:
   ```bash
   # Spell check
   npx cspell "**/*.tex" "**/*.md"
   
   # Build PDFs
   latexmk -pdf Ausarbeitung/Ausarbeitung.tex
   
   # Lint
   lacheck Ausarbeitung/Ausarbeitung.tex
   ```

2. **Review workflow logs** if checks fail

3. **Update documentation** when adding new workflows

### For Maintainers

1. **Monitor workflow runs** regularly
2. **Update dependencies** when Dependabot creates PRs
3. **Adjust configurations** as the project evolves
4. **Archive obsolete workflows** in `legacy/`

## Workflow Secrets

Some workflows may require secrets (API tokens, credentials).

### Adding Secrets

1. Go to repository Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add name and value
4. Update workflow to use: `${{ secrets.SECRET_NAME }}`

### Currently Used Secrets

- `GITHUB_TOKEN`: Automatically provided by GitHub Actions

## Caching

Workflows use caching to speed up builds:

```yaml
- name: Cache TeX Live
  uses: actions/cache@v3
  with:
    path: /usr/share/texlive
    key: texlive-${{ hashFiles('**/*.tex') }}
```

## Workflow Matrix Builds

For testing across multiple configurations:

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, macos-latest]
    texlive: [2023, 2024]
```

## Next Steps

- Review [Building PDFs](Building-PDFs.md) for local builds
- Check [Troubleshooting](Troubleshooting.md) for common issues
- Read [Contributing](Contributing.md) for contribution guidelines

---

[← Back to Wiki Home](Home.md)
