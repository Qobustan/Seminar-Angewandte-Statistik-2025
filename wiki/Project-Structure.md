# Project Structure

This document provides a comprehensive overview of the repository organization.

## Directory Structure

```
Seminar-Angewandte-Statistik-2025/
├── .github/                    # GitHub configuration and workflows
│   ├── ISSUE_TEMPLATE/        # Issue templates
│   ├── workflows/             # GitHub Actions CI/CD workflows
│   │   ├── build-and-publish-pdfs.yml
│   │   ├── lint.yml
│   │   ├── spellcheck.yml
│   │   ├── bibcheck.yml
│   │   ├── publish-wiki.yml
│   │   ├── docker-image.yml
│   │   ├── codeql-analysis.yml
│   │   ├── greetings.yml
│   │   └── format.yml
│   ├── dependabot.yml         # Dependency update automation
│   └── labeler.yml            # Automatic PR labeling
│
├── Ausarbeitung/              # Written elaboration (main paper)
│   ├── Ausarbeitung.tex       # Main LaTeX document
│   ├── header.tex             # Top-level LaTeX preamble
│   ├── header-article.tex     # Article-class preamble
│   ├── header-common.tex      # Shared preamble (common to both documents)
│   ├── Ausarbeitung.bib       # Bibliography file
│   ├── Ausarbeitung.pdf       # Compiled PDF (17 pages, committed to repo)
│   └── *.aux, *.bbl, ...      # Build auxiliary files (also committed)
│
├── Vortrag/                   # Presentation slides
│   ├── Vortrag.tex            # Main presentation document
│   ├── header.tex             # Top-level Beamer preamble
│   ├── header-beamer.tex      # Beamer-class preamble
│   ├── header-common.tex      # Shared preamble (common to both documents)
│   ├── Vortrag.bib            # Bibliography file
│   ├── Vortrag.pdf            # Compiled PDF (68 pages with pauses, committed)
│   ├── Vortrag-Druckversion.pdf  # Print version (51 pages, no pauses, committed)
│   └── img/                   # Images embedded in slides
│
├── Besprechung/               # Meeting notes and discussions
│
├── scripts/                   # Utility scripts
│   ├── generatePdf.sh         # PDF generation script (Linux/macOS)
│   ├── generatePdf.bat        # PDF generation script (Windows)
│   ├── delete-obsolete-branches.sh
│   ├── delete-obsolete-branches.py
│   └── abkuerzung.sh          # Abbreviation helper
│
├── task_skripts/              # Task-specific automation
│   ├── bash/                  # Bash scripts
│   └── perl/                  # Perl utilities
│
├── cleanup/                   # Maintenance and cleanup
│   ├── Remove_Junk_Linux.sh   # Linux cleanup script
│   └── Remove_Junk_Windows.bat # Windows cleanup script
│
├── archive/                   # Historical documentation
│
├── branch_cleanup/            # Branch deletion guides and checklists
│   ├── BRANCHES_TO_DELETE.md
│   ├── BRANCH_DELETION_CHECKLIST.md
│   └── BRANCH_DELETION_GUIDE.md
│
├── docs/                      # Additional project documentation
│   ├── ARCHITECTURE.md
│   ├── CHANGELOG.md
│   ├── PROJECT_REVIEW_SUMMARY.md
│   └── improvement/
│
├── latex_install/             # LaTeX installation guides
│   ├── LaTeX-Install.md       # English guide
│   └── LaTeX-Install.de.md    # German guide
│
├── legacy/                    # Legacy code and historical files
│
├── lua-5.5.0/                 # Lua 5.5.0 source code (compiled from source in CI)
│
├── review/                    # Review summaries
│
├── wiki/                      # Project documentation wiki
│   ├── Home.md                # Wiki home page
│   ├── Getting-Started.md     # Quick start guide
│   └── ...                    # Additional wiki pages
│
├── .gitignore                 # Git ignore patterns (LaTeX aux entries commented out)
├── .gitattributes             # Git attributes
├── cspell.json                # Spell-checking configuration
├── Dockerfile                 # Docker build environment
├── DISCLAIMER.txt             # Project disclaimer
├── SECURITY.md                # Security policy
├── CONTRIBUTING.md            # Contribution guidelines
├── VERSION                    # Current version number
└── README.md                  # Main repository documentation
```

## Key Directories Explained

### Active Development Directories

#### `Ausarbeitung/` - Written Elaboration

Contains the main LaTeX sources for the written paper:
- **Purpose**: 17-page academic paper on Nichtparametrische Statistik (KDE, nichtparametrische Regression, robuste lineare Regression)
- **Main file**: `Ausarbeitung.tex`
- **Header files**: `header.tex`, `header-article.tex`, `header-common.tex`
- **Bibliography backend**: BibTeX (`backend=bibtex`)
- **Build output**: `Ausarbeitung.pdf` (committed directly to this directory)

#### `Vortrag/` - Presentation

Contains LaTeX Beamer sources for presentation slides:
- **Purpose**: Beamer presentation for the seminar talk
- **Main file**: `Vortrag.tex`
- **Header files**: `header.tex`, `header-beamer.tex`, `header-common.tex`
- **Build outputs**: `Vortrag.pdf` (68 pages with pauses) and `Vortrag-Druckversion.pdf` (51 pages, print version without pauses) — both committed directly to this directory
- **`img/`**: Images embedded in slides (e.g., spectrophotometric measurement plots for the Itter case study)

#### `Besprechung/` - Meeting Notes

Discussion notes, meeting minutes, and collaboration materials:
- **Purpose**: Track project discussions and decisions
- **Contents**: Historical materials and meeting records

### Automation and Scripts

#### `.github/workflows/` - CI/CD Pipelines

GitHub Actions workflows for automation:
- **`build-and-publish-pdfs.yml`**: Builds PDFs using `xu-cheng/latex-action@v4` (two jobs: pdflatex + lualatex); uploads as artifacts; PDFs are also committed to repo
- **`spellcheck.yml`**: Runs spell-checking on LaTeX and markdown files
- **`bibcheck.yml`**: Validates BibTeX references
- **`format.yml`**: Checks code formatting
- **`lint.yml`**: Runs linting checks
- **`publish-wiki.yml`**: Syncs wiki/ to GitHub Wiki
- **`docker-image.yml`**: Builds Docker image for validation
- **`codeql-analysis.yml`**: Security scanning

See [CI/CD Workflows](CI-CD-Workflows.md) for detailed documentation.

#### `scripts/` - Build and Utility Scripts

Helper scripts for common tasks:
- **`generatePdf.sh`**: Automated PDF generation
- **`abkuerzung.sh`**: Abbreviation management

#### `task_skripts/` - Specialized Tools

Collection of Perl and Bash scripts for LaTeX processing:
- BibTeX conversion utilities
- LaTeX expansion and processing
- Document statistics and word counting
- Glossary generation

### Documentation and Archives

#### `archive/` - Historical Documentation

Comprehensive documentation of repository history:
- **Branch snapshots**: Detailed analysis of historical branches
- **Unique content**: Preserved configurations and code
- **Consolidation summary**: Branch management decisions

See the [Archive README](../archive/README.md) for complete details.

#### `legacy/` - Legacy Code

Preserved historical code and scripts:
- Old build scripts
- Previous documentation versions
- Historical workflows

#### `wiki/` - Project Wiki

This wiki documentation you're currently reading:
- Getting started guides
- Detailed documentation
- FAQs and troubleshooting

## Configuration Files

### Version Control

- **`.gitignore`**: Excludes build artifacts, temporary files, and dependencies
- **`.gitattributes`**: Configures Git behavior for different file types

### Code Quality

- **`cspell.json`**: Spell-checking dictionary and configuration
  - Custom dictionary for technical terms
  - LaTeX-specific exclusions
  - German and English word lists

- **`editorconfig.txt`**: Editor configuration for consistent code style
  - Indentation rules
  - Line ending preferences
  - Character encoding

### Build Environment

- **`Dockerfile`**: Containerized LaTeX build environment
  - TeX Live installation
  - Required packages
  - Build automation

### Documentation

- **`README.md`**: Main repository documentation
- **`SECURITY.md`**: Security policy and vulnerability reporting
- **`CONTRIBUTING.md`**: Contribution guidelines
- **`DISCLAIMER.txt`**: Legal disclaimer
- **`latex_install/LaTeX-Install.md`**: Installation instructions (English)
- **`latex_install/LaTeX-Install.de.md`**: Installation instructions (German)

## File Naming Conventions

### LaTeX Files

- Main documents: `Ausarbeitung.tex`, `Vortrag.tex`
- Headers/preambles: `header.tex`
- Bibliography: `*.bib` files

### Generated Files (Tracked in Git)

In this project, build artifacts **are tracked in the repository** (the `.gitignore` entries for LaTeX auxiliary files are commented out):

- PDFs: `Ausarbeitung/Ausarbeitung.pdf`, `Vortrag/Vortrag.pdf`, `Vortrag/Vortrag-Druckversion.pdf`
- LaTeX auxiliary: `*.aux`, `*.log`, `*.out`, `*.toc`, etc.
- BibTeX files: `*.bbl`, `*.blg`, `*.bcf`
- Temporary: `*.synctex.gz`, `*.nav`, `*.snm`

### Scripts

- Shell scripts: `*.sh` (Linux/macOS)
- Batch files: `*.bat` (Windows)
- Perl scripts: `*.pl`

## Branch Structure

### Active Branches

- **`main`**: Primary development branch (default)
- **Feature branches**: Temporary branches for development

### Historical Branches

All development and feature branches have been consolidated and documented in the `archive/` directory. See [Archive Documentation](../archive/README.md) for details.

## Build Artifacts

Build artifacts (PDFs, `.aux`, `.bbl`, `.log`, etc.) **are committed to this repository**. The `.gitignore` has LaTeX auxiliary file patterns listed but commented out. They are regenerated during the build process or by CI/CD workflows, but retained in git for convenience.

## Next Steps

- Learn how to [Build PDFs](Building-PDFs.md)
- Understand [CI/CD Workflows](CI-CD-Workflows.md)
- Read [Contributing Guidelines](Contributing.md)

---

[← Back to Wiki Home](Home.md)
