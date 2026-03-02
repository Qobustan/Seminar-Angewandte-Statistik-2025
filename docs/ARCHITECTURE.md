# Project Architecture

This document provides an architectural overview of the Seminar: Angewandte Statistik 2025 project.

## Table of Contents

- [Overview](#overview)
- [Directory Structure](#directory-structure)
- [Core Components](#core-components)
- [Build System](#build-system)
- [CI/CD Pipeline](#cicd-pipeline)
- [Development Workflow](#development-workflow)

---

## Overview

This is a LaTeX-based academic project repository for a seminar on Applied Statistics (Angewandte Statistik). The project consists of two main LaTeX documents:

1. **Ausarbeitung** - A comprehensive written elaboration on nonparametric statistics
2. **Vortrag** - A Beamer presentation covering the same topics

The repository is designed for:
- Automated PDF generation via GitHub Actions
- Local development with multiple LaTeX engines (pdflatex, lualatex)
- Containerized builds using Docker
- Quality assurance through linting and spell checking

---

## Directory Structure

```
.
├── Ausarbeitung/          # Written elaboration LaTeX sources
│   ├── Ausarbeitung.tex   # Main document
│   ├── header.tex         # Top-level preamble
│   ├── header-article.tex # Article-class preamble
│   ├── header-common.tex  # Shared preamble (both documents)
│   ├── Ausarbeitung.bib   # Bibliography
│   └── Ausarbeitung.pdf   # Compiled PDF (17 pages, committed to repo)
│
├── Vortrag/               # Beamer presentation LaTeX sources
│   ├── Vortrag.tex        # Main presentation file
│   ├── header.tex         # Top-level preamble
│   ├── header-beamer.tex  # Beamer-class preamble
│   ├── header-common.tex  # Shared preamble (both documents)
│   ├── Vortrag.bib        # Bibliography
│   ├── Vortrag.pdf        # Compiled PDF (68 pages with pauses, committed)
│   ├── Vortrag-Druckversion.pdf  # Print version (51 pages, no pauses, committed)
│   └── img/               # Measurement images for slides
│
├── Besprechung/           # Meeting notes and discussions
│
├── scripts/               # Build and utility scripts
│   ├── generatePdf.sh     # Main build script (Linux/macOS)
│   ├── generatePdf.bat    # Main build script (Windows)
│   └── delete-obsolete-branches.{sh,py}  # Branch cleanup utilities
│
├── cleanup/               # Cleanup scripts for LaTeX auxiliary files
│   ├── Remove_Junk_Linux.sh
│   └── Remove_Junk_Windows.bat
│
├── task_skripts/          # Task-specific helper scripts
│   ├── bash/              # Bash utility scripts
│   └── perl/              # Perl scripts (LaTeX utilities)
│
├── .github/               # GitHub-specific configurations
│   ├── workflows/         # CI/CD automation
│   │   ├── build-and-publish-pdfs.yml    # Main PDF build workflow
│   │   ├── lint.yml                       # LaTeX linting
│   │   ├── spellcheck.yml                 # Spell checking
│   │   ├── bibcheck.yml                   # Bibliography validation
│   │   ├── publish-wiki.yml               # Wiki synchronization
│   │   ├── docker-image.yml               # Docker image building
│   │   ├── codeql-analysis.yml            # Security scanning
│   │   ├── greetings.yml                  # First-contributor greeting
│   │   └── format.yml                     # Code formatting
│   ├── ISSUE_TEMPLATE/    # Issue templates
│   ├── dependabot.yml     # Automated dependency updates
│   └── labeler.yml        # Automatic PR labeling
│
├── wiki/                  # Wiki documentation (auto-synced to GitHub Wiki)
├── archive/               # Historical branch documentation
├── branch_cleanup/        # Branch deletion guides and checklists
├── legacy/                # Deprecated/archived files
├── docs/                  # Additional documentation (ARCHITECTURE, CHANGELOG, etc.)
├── latex_install/         # LaTeX installation guides (English and German)
├── lua-5.5.0/             # Lua 5.5.0 source code (compiled from source in CI)
├── review/                # Review summaries
│
├── Dockerfile             # Container definition for LaTeX builds
├── .dockerignore          # Docker build context exclusions
├── .editorconfig          # Editor configuration for consistency
├── .gitignore             # Git exclusions (LaTeX aux entries are commented out)
├── .gitattributes         # Git attributes
├── cspell.json            # Spell checker configuration
│
├── README.md              # Main project documentation
├── CONTRIBUTING.md        # Contribution guidelines
├── SECURITY.md            # Security policy
├── DISCLAIMER.txt         # Legal disclaimer
├── CHANGELOG.md           # Version history
├── VERSION                # Current version number
└── LICENSE                # MIT License

```

---

## Core Components

### 1. LaTeX Documents

#### Ausarbeitung (Written Elaboration)
- **Type:** Article-class LaTeX document (KOMA-Script)
- **Content:** Comprehensive 17-page coverage of nonparametric statistics topics
- **Key Sections:**
  1. Einleitung und Motivation (with Ausgangssituation subsection)
  2. Fallbeispiel: Gewässermessungen der Itter
  3. Der Schätzer von Rosenblatt (with Empirische Verteilungsfunktion subsection)
  4. Das Histogramm (Der Klassiker)
  5. Kerndichteschätzung (KDE) — with O-Notation, Bias-Varianz-Tradeoff, Faltungsperspektive, Vorteile
  6. Nichtparametrische Regression — Nadaraya-Watson, NW als Quotient von KDE, Bias-Problem an Datengrenzen
  7. Robuste Lineare Regression (Theil-Schätzer)
  8. Zusammenfassung und Fazit

#### Vortrag (Presentation)
- **Type:** Beamer presentation (68 pages with pause overlays; 51-page print version)
- **Content:** Condensed presentation format of Ausarbeitung topics
- **Features:**
  - Professional academic theme
  - Mathematical formulas and visualizations
  - Case study slide with real-world measurement data (Itter)
  - Progressive disclosure of concepts (configurable `\pause` switches)
  - Bibliography integration
  - **`Vortrag-Druckversion.pdf`**: 51-page print version compiled without `\pause` overlays
- **Subdirectories:**
  - `img/` — Images embedded in slides (e.g., spectrophotometric measurement plots)

### 2. Header Files

Both documents use modular `header.tex` files that define:
- Document class and options
- Package imports (amsmath, biblatex, hyperref, etc.)
- Custom commands and environments
- Typography settings (German language support)
- Bibliography style configuration
- Color schemes and formatting

### 3. Bibliography System

- **Format:** BibLaTeX
- **Backend:** BibTeX (`backend=bibtex` in `\usepackage[backend=bibtex, style=alphabetic]{biblatex}`)
- **Style:** Alphabetic citation style
- **Content:** 3 references (`BüningTrenkler+1994`, `DalItter2026`, `DalItter2021`)
- **Integration:** Citations throughout both documents

---

## Build System

### Multi-Engine Support

The project supports multiple LaTeX engines:

1. **pdflatex** (default)
   - Traditional LaTeX engine
   - Fastest compilation
   - Wide compatibility

2. **lualatex** (optional)
   - Modern LaTeX engine
   - Better Unicode support
   - Advanced font handling
   - Lua scripting capabilities

### Build Process

The standard LaTeX multi-pass compilation:

```
1. LaTeX engine (pdflatex/lualatex) → .aux, .log, .toc files
2. BibTeX → .bbl, .blg files (bibliography processing)
3. LaTeX engine → Integrate bibliography references
4. LaTeX engine → Resolve cross-references
```

### Build Scripts

#### `scripts/generatePdf.sh` (Linux/macOS)
- Configurable LaTeX engine via `LATEX_ENGINE` environment variable
- Automatic working directory detection
- Multi-pass compilation with BibTeX
- Error handling and validation

#### `scripts/generatePdf.bat` (Windows)
- Windows batch equivalent
- Same functionality as shell script
- CRLF line endings for Windows compatibility

### Cleanup

Temporary LaTeX files (.aux, .log, .toc, .synctex.gz, etc.) are removed by:
- `cleanup/Remove_Junk_Linux.sh` (Linux/macOS)
- `cleanup/Remove_Junk_Windows.bat` (Windows)

---

## CI/CD Pipeline

### GitHub Actions Workflows

#### 1. Build and Publish PDFs (`build-and-publish-pdfs.yml`)
- **Trigger:** Push to main/master, manual dispatch
- **Engine Selection:** pdflatex (default) or lualatex (manual dispatch)
- **Two Build Jobs:**
  - `build-latex`: pdflatex (default) using `xu-cheng/latex-action@v4` with Docker image `ghcr.io/xu-cheng/texlive-full`
  - `build-latex-lualatex`: lualatex (always runs) using the same action and image
- **Process:**
  1. Checkout repository
  2. Build Ausarbeitung.pdf using `xu-cheng/latex-action@v4`
  3. Build Vortrag.pdf and Vortrag-Druckversion.pdf using `xu-cheng/latex-action@v4`
  4. Build Lua 5.5.0 from source (`lua-5.5.0/` directory)
  5. Upload all PDFs as artifacts (90-day retention)
- **Artifacts:** Available in Actions tab → workflow run → latex-pdfs
- **Note:** PDFs are also committed directly to the repository alongside LaTeX sources

#### 2. LaTeX Linting (`lint.yml`)
- **Tool:** chktex
- **Purpose:** Detect common LaTeX errors and style issues
- **Scope:** All .tex files in Ausarbeitung/ and Vortrag/

#### 3. Spell Checking (`spellcheck.yml`)
- **Tool:** cspell
- **Configuration:** cspell.json with custom dictionary
- **Scope:** .tex and .md files
- **Languages:** German (de) and English (en)

#### 4. Bibliography Check (`bibcheck.yml`)
- **Purpose:** Detect duplicate bibliography entries
- **Scope:** .bib files

#### 5. Wiki Publishing (`publish-wiki.yml`)
- **Trigger:** Changes to wiki/ directory
- **Process:** Syncs markdown files from wiki/ to GitHub Wiki
- **Technology:** GitHub API integration

#### 6. Docker Image (`docker-image.yml`)
- **Purpose:** Build and optionally publish Docker image
- **Base:** Ubuntu 20.04 with texlive-full

### Automation Features

- **Dependabot:** Automatically updates GitHub Actions weekly
- **Auto-labeling:** Applies labels to PRs based on file changes
- **Stale issue management:** Marks inactive issues as stale
- **Greeting bot:** Welcome message for first-time contributors

---

## Development Workflow

### Local Development

1. **Clone repository**
   ```bash
   git clone https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git
   cd Seminar-Angewandte-Statistik-2025
   ```

2. **Install prerequisites**
   - TeX Live or MiKTeX (LaTeX distribution)
   - Optional: Docker, chktex, cspell

3. **Build PDFs**
   ```bash
   # Using build script
   ./scripts/generatePdf.sh
   
   # Using latexmk directly
   cd Ausarbeitung && latexmk -pdf Ausarbeitung.tex
   
   # Using Docker
   docker build -t latex-seminar .
   docker run --rm -v $(pwd):/app latex-seminar
   ```

4. **Clean up**
   ```bash
   ./cleanup/Remove_Junk_Linux.sh
   ```

### Contribution Workflow

1. **Fork** and create a feature branch
2. **Make changes** to LaTeX files
3. **Test locally** - build PDFs and check output
4. **Run quality checks** (optional: lint, spellcheck)
5. **Clean** temporary files
6. **Commit** with descriptive messages
7. **Push** and open Pull Request
8. **CI/CD** automatically validates changes

### Docker Development

The Dockerfile provides a reproducible build environment:

```dockerfile
# Multi-stage build
Stage 1: Base image with TeX Live
Stage 2: Application setup with non-root user

# Features:
- Ubuntu 20.04 base
- texlive-full installation
- Non-root user for security
- Health checks
- Volume support for live editing
```

**Benefits:**
- Consistent build environment across systems
- No need to install LaTeX locally
- Isolated from host system
- Reproducible builds

---

## Technology Stack

### Core Technologies
- **LaTeX:** Document typesetting
- **BibTeX/BibLaTeX:** Bibliography management
- **Beamer:** Presentation framework
- **KOMA-Script:** Enhanced document classes

### LaTeX Packages
- `amsmath`, `amssymb`, `amsthm` - Mathematics
- `babel[ngerman]` - German language support
- `biblatex` - Bibliography management
- `csquotes` - Quotation marks
- `hyperref` - Hyperlinks and PDF metadata
- `graphicx` - Image inclusion
- `tikz` - Graphics and diagrams
- `listings` - Code listings

### Build Tools
- **latexmk:** Automated LaTeX building with dependency tracking
- **pdflatex:** Standard LaTeX to PDF compiler
- **lualatex:** Modern LaTeX compiler with extended features
- **bibtex:** Bibliography processor

### CI/CD Tools
- **GitHub Actions:** Workflow automation
- **xu-cheng/latex-action:** Reliable LaTeX building in CI
- **chktex:** LaTeX linter
- **cspell:** Spell checker
- **Docker:** Containerization

### Development Tools
- **Git:** Version control
- **EditorConfig:** Consistent coding style
- **Dependabot:** Automated dependency updates

---

## Configuration Files

### `.editorconfig`
Ensures consistent coding style across editors:
- LaTeX: 4 spaces (tabs), UTF-8, LF line endings
- Markdown: 2 spaces, UTF-8, LF line endings
- Shell scripts: 4 spaces, UTF-8, LF line endings
- Batch files: 4 spaces, UTF-8, CRLF line endings
- YAML/JSON: 2 spaces, UTF-8, LF line endings

### `cspell.json`
Spell checker configuration:
- Languages: German (de), English (en)
- Custom dictionary with 260+ project-specific terms
- Ignores: LaTeX commands, math mode, citations
- Patterns for markdown code blocks, LaTeX math

### `.gitignore`
Excludes from version control:
- Build artifacts (build/, out/, dist/)
- Editor files (.vscode/, .idea/)
- OS files (.DS_Store, Thumbs.db)
- Python cache (__pycache__/)
- **Note:** LaTeX auxiliary file patterns (*.aux, *.log, *.bbl, etc.) are listed but **commented out** — these files ARE tracked in this repository.

### `.dockerignore`
Excludes from Docker build context:
- .git/
- Auxiliary LaTeX files
- Documentation (markdown files)
- CI/CD configuration

---

## Quality Assurance

### Pre-commit Checks (Manual)
1. Build both PDFs successfully
2. Run LaTeX linter (chktex)
3. Run spell checker (cspell)
4. Visual inspection of PDF output
5. Clean temporary files

### Automated CI Checks
1. LaTeX compilation (pdflatex)
2. Linting (chktex)
3. Spell checking (cspell)
4. Bibliography validation

### Code Review
- Pull requests require review
- CODEOWNERS automatically requests review from maintainers
- PR template ensures completeness

---

## Best Practices

### LaTeX
- Use semantic commands (`\emph{}` not `\textit{}`)
- Comment complex macros
- Keep line length under 120 characters
- Use `\enquote{}` for quotations (German)
- Cite sources properly with BibTeX

### Git
- Clear, descriptive commit messages
- Feature branches for changes
- Keep commits atomic and focused
- Clean up temporary files before committing

### Documentation
- Update README when adding features
- Document script parameters
- Add inline comments for complex logic
- Update CHANGELOG for notable changes

---

## Security Considerations

### Build Security
- LaTeX runs in isolated CI/CD environments
- Docker provides containerization
- No shell escape features (`\write18`) used
- All builds run with `-interaction=nonstopmode`

### Supply Chain Security
- GitHub Actions pinned to specific versions
- Dependabot monitors for updates
- Limited use of third-party actions
- CI builds use `xu-cheng/latex-action@v4` with Docker image `ghcr.io/xu-cheng/texlive-full`

### Access Control
- Branch protection on main branch
- Code review required for PRs
- CODEOWNERS defines ownership
- Secrets scoped appropriately

See [SECURITY.md](../SECURITY.md) for full security policy.

---

## Future Enhancements

Potential areas for expansion:
- Automated release generation
- Additional LaTeX engines (XeLaTeX)
- Enhanced visualization scripts
- Automated code quality metrics
- Integration with LaTeX language servers
- PDF diff visualization for changes

---

## References

- [LaTeX Project](https://www.latex-project.org/)
- [KOMA-Script Documentation](https://www.ctan.org/pkg/koma-script)
- [Beamer User Guide](https://www.ctan.org/pkg/beamer)
- [BibLaTeX Documentation](https://www.ctan.org/pkg/biblatex)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

---

*Last Updated: March 2026*
*Version: 1.1.0*
