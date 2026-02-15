# Seminar: Angewandte Statistik 2025

A comprehensive LaTeX project repository for the Applied Statistics seminar, Wintersemester 2025/26.

**Author:** Yavuzâlp Dal
**Semester:** Wintersemester 2025/26

📚 **[Visit our Wiki](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki)** for comprehensive documentation and guides.

---

## Table of Contents

- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Building the PDFs](#building-the-pdfs)
  - [Manual Compilation](#manual-compilation)
  - [Using latexmk](#using-latexmk)
  - [Using Docker](#using-docker)
  - [Using GitHub Actions](#using-github-actions)
- [CI/CD Workflows](#cicd-workflows)
- [Available Scripts](#available-scripts)
- [Contributing](#contributing)
- [Important Notices](#important-notices)
- [Additional Documentation](#additional-documentation)

---

## Repository Structure

```
.
├── Ausarbeitung/            # LaTeX sources for the written elaboration
├── Vortrag/                 # LaTeX sources for the presentation
├── Besprechung/             # Meeting notes and discussions
├── scripts/                 # Build and utility scripts
├── cleanup/                 # Cleanup scripts for temporary LaTeX files
├── task_skripts/            # Task-specific scripts (bash, perl)
│   ├── bash/
│   └── perl/
├── legacy/                  # Archived, deprecated files
├── archive/                 # Branch documentation and historical content
│   ├── branch-snapshots/
│   └── unique-content/
├── .github/workflows/       # CI/CD automation
└── wiki/                    # Project wiki documentation
```

### Directory Descriptions

- **`Ausarbeitung/`** - Contains LaTeX source files for the written elaboration (Ausarbeitung.tex, header.tex, bibliography)
- **`Vortrag/`** - Contains LaTeX source files for the Beamer presentation (Vortrag.tex)
- **`Besprechung/`** - Meeting notes, discussion materials, and related documents
- **`scripts/`** - Utility scripts for PDF generation (`generatePdf.sh`, `generatePdf.bat`)
- **`cleanup/`** - Scripts to remove temporary LaTeX auxiliary files (`Remove_Junk_*.sh|bat`)
- **`task_skripts/`** - Task-specific scripts organized by language (bash, perl)
- **`legacy/`** - Archived files and historical code no longer actively used
- **`archive/`** - Historical branch documentation and unique content preservation
- **`.github/workflows/`** - GitHub Actions workflows for automated building, linting, and testing

---

## Prerequisites

### Required

- **TeX Live** (or MiKTeX on Windows) - LaTeX distribution
  - `pdflatex` - PDF generation
  - `bibtex` or `biber` - Bibliography management
  - `latexmk` - Automated LaTeX building (recommended)
- **Git** - Version control

### Optional

- **Docker** - For containerized builds
- **LuaLaTeX** - Optional LaTeX engine (alternative to pdflatex)
- **Perl** - Required for certain task scripts in `task_skripts/perl/`
- **chktex** - LaTeX linter (used in CI)
- **cspell** - Spell checker (used in CI)

For detailed installation instructions, see:
- [LaTeX Installation Guide (English)](latex_install/LaTeX-Install.md)
- [LaTeX Installation Guide (German)](latex_install/LaTeX-Install.de.md)

---

## Building the PDFs

### Manual Compilation

Build PDFs using the traditional pdflatex + bibtex multi-pass approach:

```bash
# Build Ausarbeitung
cd Ausarbeitung
pdflatex -interaction=nonstopmode Ausarbeitung.tex
bibtex Ausarbeitung
pdflatex -interaction=nonstopmode Ausarbeitung.tex
pdflatex -interaction=nonstopmode Ausarbeitung.tex

# Build Vortrag
cd ../Vortrag
pdflatex -interaction=nonstopmode Vortrag.tex
bibtex Vortrag
pdflatex -interaction=nonstopmode Vortrag.tex
pdflatex -interaction=nonstopmode Vortrag.tex
```

#### Using LuaLaTeX (Optional)

LuaLaTeX is available as an alternative to pdflatex. It provides better Unicode support, more advanced font handling, and can handle complex documents more efficiently:

```bash
# Build Ausarbeitung with LuaLaTeX
cd Ausarbeitung
lualatex -interaction=nonstopmode Ausarbeitung.tex
bibtex Ausarbeitung
lualatex -interaction=nonstopmode Ausarbeitung.tex
lualatex -interaction=nonstopmode Ausarbeitung.tex

# Build Vortrag with LuaLaTeX
cd ../Vortrag
lualatex -interaction=nonstopmode Vortrag.tex
bibtex Vortrag
lualatex -interaction=nonstopmode Vortrag.tex
lualatex -interaction=nonstopmode Vortrag.tex
```

### Using latexmk

Automated building with dependency tracking (recommended):

```bash
# Build Ausarbeitung with pdflatex (default)
cd Ausarbeitung
latexmk -pdf Ausarbeitung.tex

# Build Vortrag with pdflatex (default)
cd ../Vortrag
latexmk -pdf Vortrag.tex
```

#### Using latexmk with LuaLaTeX (Optional)

```bash
# Build Ausarbeitung with LuaLaTeX
cd Ausarbeitung
latexmk -lualatex Ausarbeitung.tex

# Build Vortrag with LuaLaTeX
cd ../Vortrag
latexmk -lualatex Vortrag.tex
```

### Using Docker

Build PDFs in a containerized environment:

```bash
# Build the Docker image
docker build -t latex-seminar .

# Run the container to generate PDFs (default: pdflatex)
docker run --rm -v $(pwd):/app latex-seminar

# Run with LuaLaTeX
docker run --rm -e LATEX_ENGINE=lualatex -v $(pwd):/app latex-seminar
```

The Dockerfile includes TeX Live with full LaTeX support (pdflatex, lualatex, xelatex), German language support, and all necessary dependencies.

### Using GitHub Actions

PDFs are automatically built on every push to the `main` branch using pdflatex by default:

1. Push your changes to the `main` branch
2. GitHub Actions automatically builds both PDFs
3. Download generated PDFs from the workflow artifacts

**Using LuaLaTeX in GitHub Actions:**

1. Go to the Actions tab in the repository
2. Select "Kompiliere die LateX-Ausarbeitung und den Beamer-Vortrag" workflow
3. Click "Run workflow"
4. Select "lualatex" from the dropdown menu
5. Click "Run workflow" button
6. Download the generated PDFs from the workflow artifacts

See the [CI/CD Workflows](#cicd-workflows) section for details.

---

## CI/CD Workflows

The repository includes comprehensive GitHub Actions workflows in `.github/workflows/`:

### Main Workflows

- **`build-and-publish-pdfs.yml`** - Automatically compiles LaTeX documents
  - Triggers on push to `main` or manual dispatch
  - Uses `xu-cheng/latex-action@v4` for reliable PDF generation
  - Default: pdflatex for backwards compatibility
  - Manual dispatch: Choose between pdflatex or lualatex
  - Uploads generated PDFs as artifacts
  - Artifacts are available for 90 days after each workflow run

- **`publish-wiki.yml`** - Publishes wiki documentation to GitHub Wiki
  - Triggers on push to `main/master` when wiki files change or manual dispatch
  - Syncs markdown files from `wiki/` directory to the repository's GitHub Wiki
  - Uses pinned commit SHA to avoid firewall issues

- **`docker-image.yml`** - Docker image validation
  - Triggers on push or pull request to `main` branch
  - Builds Docker image to verify Dockerfile integrity
  - Does not push image to registry (validation only)
  - Ensures containerized build environment remains functional

- **`codeql-analysis.yml`** - Security code scanning with CodeQL
  - Triggers on push/PR to `main` or weekly schedule (Mondays)
  - Analyzes Python scripts for security vulnerabilities
  - Results available in repository's Security tab
  - Helps identify potential security issues early

- **`lint.yml`** - LaTeX linting with chktex
- **`spellcheck.yml`** - Spell checking with cspell
- **`format.yml`** - Code formatting checks
- **`bibcheck.yml`** - Bibliography validation

### Accessing Generated PDFs

After a successful build:
1. Go to the Actions tab in the GitHub repository
2. Select the latest workflow run
3. Download the `latex-pdfs` artifact containing both PDFs

---

## Available Scripts

### PDF Generation

**`scripts/generatePdf.sh`** (Linux/macOS) / **`scripts/generatePdf.bat`** (Windows)
- Builds both Ausarbeitung and Vortrag PDFs
- Runs the LaTeX engine (pdflatex by default) and bibtex with proper multi-pass compilation
- Supports optional LuaLaTeX via LATEX_ENGINE environment variable
- Usage (default): `./scripts/generatePdf.sh`
- Usage (LuaLaTeX): `LATEX_ENGINE=lualatex ./scripts/generatePdf.sh`
- Windows (default): `scripts\generatePdf.bat`
- Windows (LuaLaTeX): Use two commands: `set LATEX_ENGINE=lualatex` then `scripts\generatePdf.bat`

### Cleanup Scripts

**`cleanup/Remove_Junk_Linux.sh`** (Linux/macOS) / **`cleanup/Remove_Junk_Windows.bat`** (Windows)
- Removes temporary LaTeX auxiliary files
- Cleans `.aux`, `.log`, `.toc`, `.bbl`, `.blg`, `.synctex.gz`, and other build artifacts
- Runs cleanup in both Ausarbeitung and Vortrag directories
- Usage: `./cleanup/Remove_Junk_Linux.sh`

### Task-Specific Scripts

Located in `task_skripts/`:
- `bash/` - Bash scripts for various tasks
- `perl/` - Perl scripts for text processing

Most scripts support a `--help` option for usage information.

### Branch Management

**`scripts/delete-obsolete-branches.sh`** / **`scripts/delete-obsolete-branches.py`**
- Deletes obsolete branches from the repository
- Removes old feature branches and merged PR branches
- Keeps main branch and active PR branches
- See `BRANCHES_TO_DELETE.md` for the list of branches to be removed
- Usage (Bash): `./scripts/delete-obsolete-branches.sh`
- Usage (Python): `python3 scripts/delete-obsolete-branches.py` (requires `GITHUB_TOKEN` environment variable)
- Dry run: `python3 scripts/delete-obsolete-branches.py --dry-run`

---

## Contributing

Contributions are welcome! Please see our [Contributing Guidelines](CONTRIBUTING.md) for detailed information.

### Quick Start

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes and test locally by building the PDFs
4. Commit your changes with clear, descriptive messages
5. Push to your fork and open a Pull Request

For detailed guidelines on LaTeX conventions, quality checks, and the PR process, see [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Important Notices

### Disclaimer

This project is provided "as is" without warranty. See [DISCLAIMER.txt](DISCLAIMER.txt) for full details.

**Key Points:**
- No warranty of any kind
- Not intended for personal data processing
- User assumes all risks for uploaded content
- No liability for damages or claims

### Security Policy

For information about supported versions and reporting vulnerabilities, see [SECURITY.md](SECURITY.md).

---

## Additional Documentation

- [Contributing Guidelines](CONTRIBUTING.md) - How to contribute to this project
- [LaTeX Installation Guide (English)](latex_install/LaTeX-Install.md) - Comprehensive LaTeX setup instructions
- [LaTeX Installation Guide (German)](latex_install/LaTeX-Install.de.md) - Deutsche LaTeX-Installationsanleitung
- [Branch Archive Documentation](archive/README.md) - Historical branch consolidation and analysis
- [Security Policy](SECURITY.md) - Security guidelines and vulnerability reporting

### Wiki Documentation

The `wiki/` directory contains additional documentation that is automatically synced to the [GitHub Wiki](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki):
- [Getting Started Guide](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Getting-Started)
- [Building PDFs](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Building-PDFs)
- [CI/CD Workflows](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/CI-CD-Workflows)
- [Contributing Guidelines](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Contributing)
- [FAQ](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/FAQ)
- [Troubleshooting](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Troubleshooting)
- [Project Structure](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/Project-Structure)

**Note:** Changes to files in the `wiki/` directory are automatically synced to the GitHub Wiki when pushed to the main branch.

---

## Workflow Status Badges

[![Build LaTeX PDFs](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml)
[![LaTeX Lint](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/lint.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/lint.yml)
[![Spellcheck](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/spellcheck.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/spellcheck.yml)
[![Bibliography Check](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/bibcheck.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/bibcheck.yml)
[![Docker Image CI](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/docker-image.yml)
[![CodeQL Analysis](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/codeql-analysis.yml)
[![Publish Wiki](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/publish-wiki.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/publish-wiki.yml)
