# Project Structure

This document provides a comprehensive overview of the repository organization.

## Directory Structure

```
Seminar-Angewandte-Statistik-2025/
├── .github/                    # GitHub configuration and workflows
│   ├── ISSUE_TEMPLATE/        # Issue templates
│   ├── workflows/             # GitHub Actions CI/CD workflows
│   ├── dependabot.yml         # Dependency update automation
│   └── labeler.yml            # Automatic PR labeling
│
├── Ausarbeitung/              # Written elaboration (main paper)
│   ├── Ausarbeitung.tex       # Main LaTeX document
│   ├── header.tex             # LaTeX preamble and packages
│   └── Ausarbeitung.bib       # Bibliography file
│
├── Vortrag/                   # Presentation slides
│   ├── Vortrag.tex            # Main presentation document
│   ├── header.tex             # Beamer configuration
│   └── Vortrag.bib            # Bibliography file
│
├── Besprechung/               # Meeting notes and discussions
│   └── Material/              # Historical meeting materials
│
├── scripts/                   # Utility scripts
│   ├── generatePdf.sh         # PDF generation script
│   └── abkuerzung.sh          # Abbreviation helper
│
├── task_skripts/              # Task-specific automation
│   ├── bash/                  # Bash scripts
│   │   └── doc_version.sh     # Document versioning
│   └── perl/                  # Perl utilities
│       ├── bibtex2html.pl     # BibTeX conversion
│       ├── texcount.pl        # Word counting
│       └── ...                # Other LaTeX tools
│
├── cleanup/                   # Maintenance and cleanup
│   ├── Remove_Junk_Linux.sh   # Linux cleanup script
│   └── Remove_Junk_Windows.bat # Windows cleanup script
│
├── archive/                   # Historical documentation
│   ├── README.md              # Archive overview
│   ├── CONSOLIDATION-SUMMARY.md # Branch consolidation summary
│   ├── branch-snapshots/      # Historical branch documentation
│   │   ├── 01-template-fork.md
│   │   ├── 02-development-milestones.md
│   │   └── 03-copilot-branches.md
│   └── unique-content/        # Preserved unique configurations
│
├── legacy/                    # Legacy code and historical files
│   ├── build.sh               # Old build script
│   ├── debug.sh               # Old debug script
│   └── README.md              # Legacy documentation
│
├── wiki/                      # Project documentation wiki
│   ├── Home.md                # Wiki home page
│   ├── Getting-Started.md     # Quick start guide
│   └── ...                    # Additional wiki pages
│
├── .gitignore                 # Git ignore patterns
├── .gitattributes             # Git attributes
├── cspell.json                # Spell-checking configuration
├── Dockerfile                 # Docker build environment
├── editorconfig.txt           # Editor configuration
├── DISCLAIMER.txt             # Project disclaimer
├── SECURITY.md                # Security policy
├── LaTeX-Install.md           # LaTeX installation guide (English)
├── LaTeX-Install.de.md        # LaTeX installation guide (German)
└── README.md                  # Main repository documentation
```

## Key Directories Explained

### Active Development Directories

#### `Ausarbeitung/` - Written Elaboration

Contains the main LaTeX sources for the written paper/thesis:
- **Purpose**: Academic paper or thesis document
- **Main file**: `Ausarbeitung.tex`
- **Build output**: `Ausarbeitung.pdf`
- **Structure**: Single-document format with sections

#### `Vortrag/` - Presentation

Contains LaTeX Beamer sources for presentation slides:
- **Purpose**: Presentation slides for seminar talks
- **Main file**: `Vortrag.tex`
- **Build output**: `Vortrag.pdf`
- **Structure**: Beamer presentation with frames

#### `Besprechung/` - Meeting Notes

Discussion notes, meeting minutes, and collaboration materials:
- **Purpose**: Track project discussions and decisions
- **Contents**: Historical materials and meeting records

### Automation and Scripts

#### `.github/workflows/` - CI/CD Pipelines

GitHub Actions workflows for automation:
- **`build-and-publish-pdfs.yml`**: Builds and publishes PDFs to `pdfs` branch
- **`spellcheck.yml`**: Runs spell-checking on LaTeX and markdown files
- **`bibcheck.yml`**: Validates BibTeX references
- **`format.yml`**: Checks code formatting
- **`lint.yml`**: Runs linting checks
- **`summary.yml`**: Generates project summary
- **`stale.yml`**: Manages stale issues and PRs

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
- **`LaTeX-Install.md`**: Installation instructions (English)
- **`LaTeX-Install.de.md`**: Installation instructions (German)
- **`DISCLAIMER.txt`**: Legal disclaimer

## File Naming Conventions

### LaTeX Files

- Main documents: `Ausarbeitung.tex`, `Vortrag.tex`
- Headers/preambles: `header.tex`
- Bibliography: `*.bib` files

### Generated Files (Git Ignored)

- PDFs: `*.pdf`
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
- **`pdfs`**: Automatically updated with built PDFs
- **Template branch**: Preserved for future reference (not to be merged)

### Historical Branches

All development and feature branches have been consolidated and documented in the `archive/` directory. See [Archive Documentation](../archive/README.md) for details.

## Build Artifacts

Build artifacts are automatically excluded from Git via `.gitignore`:

- PDF outputs
- LaTeX auxiliary files
- Bibliography intermediates
- Index and glossary files
- Temporary build files

These are regenerated during the build process or by CI/CD workflows.

## Next Steps

- Learn how to [Build PDFs](Building-PDFs.md)
- Understand [CI/CD Workflows](CI-CD-Workflows.md)
- Read [Contributing Guidelines](Contributing.md)

---

[← Back to Wiki Home](Home.md)
