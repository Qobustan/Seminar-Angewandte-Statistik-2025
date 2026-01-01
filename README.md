# Seminar: Angewandte Statistik 2025

[![Build all LaTeX projects](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml)

Welcome to the repository for the **Angewandte Statistik** seminar (2025). This repository contains all materials for the seminar, including written elaborations (Ausarbeitung), presentation slides (Vortrag), and discussion materials (Besprechung).

## Repository Structure

```
.
├── Ausarbeitung/       # Written elaboration (LaTeX sources)
├── Vortrag/           # Presentation slides (Beamer LaTeX sources)
├── Besprechung/       # Discussion materials
├── scripts/           # Build and utility scripts
├── task_skripts/      # Task-specific scripts
└── .github/workflows/ # CI/CD automation
```

## Quick Start

### Prerequisites

- LaTeX distribution (TeX Live, MiKTeX, or similar)
- For local installation instructions, see [LaTeX-Install.md](LaTeX-Install.md) (English) or [LaTeX-Install.de.md](LaTeX-Install.de.md) (German)

### Building Locally

Build individual documents with pdflatex (multiple passes needed for bibliography and references):

```bash
# Build Ausarbeitung (written paper)
cd Ausarbeitung
pdflatex Ausarbeitung.tex
bibtex Ausarbeitung
pdflatex Ausarbeitung.tex
pdflatex Ausarbeitung.tex

# Build Vortrag (presentation)
cd Vortrag
pdflatex Vortrag.tex
bibtex Vortrag
pdflatex Vortrag.tex
pdflatex Vortrag.tex
```
## Repository Structure

### Active Directories
- `Ausarbeitung/` — LaTeX sources for the written elaboration
- `Vortrag/` — LaTeX sources for the presentation
- `Besprechung/` — Meeting notes and discussions
- `scripts/` — Utility scripts for building and maintenance
- `cleanup/` — Cleanup and maintenance scripts
- `task_skripts/` — Task-specific scripts
- `legacy/` — Legacy files and historical code
- `.github/workflows/` — CI/CD automation

### Archive
- `archive/` — **Historical branch documentation and unique content preservation**
  - See [`archive/README.md`](archive/README.md) for comprehensive documentation of all archived branches
  - Contains snapshots and unique content from historical development branches

## CI/CD

A GitHub Actions workflow is provided (`.github/workflows/build-and-publish-pdfs.yml`).
On pushes to main (and when manually triggered) it:
- installs a minimal TeX Live setup
- builds PDFs from the LaTeX files in `Ausarbeitung/` and `Vortrag/` using latexmk with PDFLaTeX
- collects the generated PDFs and publishes them to a dedicated branch named 'pdfs'

## Usage

- Edit the LaTeX sources in `Ausarbeitung/` and `Vortrag/` and push to main.
The workflow will automatically build and update the 'pdfs' branch with the generated PDFs.

## Branch Management

This repository has undergone branch consolidation. Historical branches have been documented and archived:

### Active Branches
- **`main`** - Primary development branch
- **`Einen-Fork-für-eine-potentielle-Vorlage-in-der-Zukunft-(soll-nicht-gemerged-werden)`** - Template reference (preserved, not to be merged)

### Archived Branches
All historical development branches have been consolidated and documented in the [`archive/`](archive/) directory:
- **Development Milestones**: 6 branches documenting various development stages
- **Copilot Automation**: 12+ branches from automated improvements
- See [`archive/README.md`](archive/README.md) for complete branch analysis and deletion recommendations

### Branch Archive Structure
```
archive/
├── README.md                           # Overview and consolidation rationale
├── branch-snapshots/                   # Detailed branch documentation
│   ├── 01-template-fork.md            # Template branch analysis
│   ├── 02-development-milestones.md   # Historical milestones
│   └── 03-copilot-branches.md         # Automated improvement branches
└── unique-content/                     # Preserved unique configurations
    └── README.md                       # Guide to accessing unique content
```

**Key Benefits of Consolidation**:
- Clear documentation of branch history and purpose
- Preserved unique content and configurations
- Cleaner repository with reduced branch clutter
- Traceability for future reference
- Informed deletion decisions

## Notes

- The workflow looks for the first .tex file in each directory.
If you use other filenames, ensure the main document is the first .tex file in the directory (or modify the workflow to point to the correct root files).
- The workflow installs a subset of TeX Live packages (mainly pdflatex and dependencies) which are necessary for this project and shall be sufficient for many documents using PDFLaTeX.
If your project depends on other packages, update the workflow to install additional texlive packages or a fuller TeX Live distribution.

## Additional Documentation

- [LaTeX Installation Guide (English)](LaTeX-Install.md)
- [LaTeX Installation Guide (German)](LaTeX-Install.de.md)
- [Branch Archive Documentation](archive/README.md)
- [Security Policy](SECURITY.md)

---

Alternatively, use `latexmk` for automatic compilation with all necessary passes:

```bash
# Build Ausarbeitung
(cd Ausarbeitung && latexmk -pdf Ausarbeitung.tex)

# Build Vortrag
(cd Vortrag && latexmk -pdf Vortrag.tex)
```

## Continuous Integration and Automation

This repository uses GitHub Actions for automated PDF generation and quality assurance.

### Build Workflow

**Workflow:** [build-and-publish-pdfs.yml](.github/workflows/build-and-publish-pdfs.yml)

On every push to `main` (or when manually triggered):
1. Compiles `Ausarbeitung.tex` from the `Ausarbeitung/` directory
2. Compiles `Vortrag.tex` from the `Vortrag/` directory  
3. Uploads generated PDFs as build artifacts

### Quality Assurance Workflows

The repository includes several automated quality checks to maintain high standards:

#### Spellcheck
**Workflow:** [spellcheck.yml](.github/workflows/spellcheck.yml)
- Runs automatically on all pushes and pull requests
- Uses `cspell` with German and LaTeX dictionaries
- Checks all `.tex`, `.md`, and `.txt` files
- Posts spellcheck results as PR comments when issues are found

#### LaTeX Linting
**Workflow:** [lint.yml](.github/workflows/lint.yml)
- Runs automatically on all pushes and pull requests
- Uses `chktex` to detect common LaTeX errors and style issues
- Helps maintain consistent LaTeX code quality

#### LaTeX Formatting
**Workflow:** [format.yml](.github/workflows/format.yml)
- Available for manual trigger only
- Uses `latexindent` to format LaTeX source files
- Automatically formats all `.tex` files in the repository

#### Bibliography Check
**Workflow:** [bibcheck.yml](.github/workflows/bibcheck.yml)
- Validates bibliography entries and citations

#### Docker Image Build
**Workflow:** [docker-image.yml](.github/workflows/docker-image.yml)
- Builds Docker image for reproducible compilation environment

### Downloading PDFs

After each successful build, the generated PDFs are available as artifacts:
1. Go to the [Actions tab](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions)
2. Click on the latest successful workflow run
3. Download the `latex-pdfs` artifact

## Development

### Editing LaTeX Sources

- **Ausarbeitung:** Edit `Ausarbeitung/Ausarbeitung.tex` for the written paper
- **Vortrag:** Edit `Vortrag/Vortrag.tex` for the presentation slides

Both directories include a `header.tex` file for shared preamble configurations.

### Code Quality Best Practices

When working with LaTeX sources in this repository:

1. **Run Local Checks:** Test your LaTeX code locally before pushing
2. **Spellcheck:** Ensure text is spell-checked (especially German content)
3. **Bibliography:** Verify all citations are properly referenced in `.bib` files
4. **Formatting:** Consider running `latexindent` locally for consistent formatting
5. **Compilation:** Ensure documents compile without errors using both `pdflatex` and `bibtex`

### Local Development Tools

**ChkTeX** - LaTeX linter:
```bash
chktex Ausarbeitung/Ausarbeitung.tex
chktex Vortrag/Vortrag.tex
```

**Latexindent** - LaTeX formatter:
```bash
latexindent -w Ausarbeitung/Ausarbeitung.tex
latexindent -w Vortrag/Vortrag.tex
```

**Cspell** - Spell checker:
```bash
npm install -g cspell
cspell "**/*.tex" "**/*.md"
```

### Adding Dependencies

If your LaTeX documents require additional packages not included in the standard TeX Live distribution, you may need to update the GitHub Actions workflow. The workflow uses the [xu-cheng/latex-action](https://github.com/xu-cheng/latex-action) which provides a full TeX Live installation with most common packages.

## Project Files and Resources

### Configuration Files
- **cspell.json:** Spellchecker configuration with custom dictionary entries
- **.gitignore:** Specifies files to exclude from version control (LaTeX auxiliary files, build outputs)
- **.gitattributes:** Git attributes for handling line endings and file types
- **editorconfig.txt:** Editor configuration settings for consistent code style

### Documentation
- **DISCLAIMER.txt:** General disclaimer and warranty information
- **SECURITY.md:** Security policy and vulnerability reporting
- **LaTeX-Install.md:** LaTeX installation guide (English)
- **LaTeX-Install.de.md:** LaTeX installation guide (German)

### Build and Development Tools
- **Dockerfile:** Container definition for reproducible compilation environment
- **build.sh:** Build script for web application deployment
- **legacy/debug.sh:** Legacy debugging script for troubleshooting web application builds (not used for LaTeX compilation)
- **cleanup/:** Scripts for cleaning temporary and auxiliary LaTeX files

### Directory Organization
- **Ausarbeitung/:** Main written elaboration with LaTeX sources and bibliography
- **Vortrag/:** Presentation slides using Beamer class
- **Besprechung/:** Discussion materials and meeting notes
- **scripts/:** Build automation and utility scripts
- **task_skripts/:** Task-specific helper scripts
- **legacy/:** Archived or deprecated content for reference

## Contributing

We welcome contributions to improve the seminar materials. Please follow these guidelines:

### Workflow
1. Create a feature branch from `main`
2. Make your changes to LaTeX sources or documentation
3. Test locally to ensure PDFs compile correctly
4. Run quality checks (spellcheck, linting) before committing
5. Push your changes and create a pull request
6. Wait for automated CI checks to complete
7. Address any issues found by automated workflows
8. Request review from project maintainers

### Commit Message Guidelines
- Use clear, descriptive commit messages
- Reference issue numbers when applicable
- Keep commits focused on a single logical change

### Pull Request Process
- Provide a clear description of changes
- Ensure all CI workflows pass successfully
- Respond to review comments promptly
- Update documentation if you change functionality

## Important Notes

### Build Artifacts
- The CI workflow automatically builds PDFs on push to `main`
- Build artifacts are retained for 90 days by default
- Download artifacts from the [Actions tab](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions)

### LaTeX Compilation
- Make sure your LaTeX sources compile without errors before pushing
- Multiple compilation passes are required for proper bibliography and cross-references
- Auxiliary files (.aux, .log, .bbl, etc.) are excluded from version control

### Quality Standards
- All contributions are subject to automated quality checks
- Spellcheck runs on every push and pull request
- LaTeX linting helps catch common errors early
- Fix any issues reported by automated workflows before merging

### Working with Bibliographies
- Bibliography files (.bib) are located in respective project directories
- Use proper BibTeX format for all references
- Run `bibtex` after `pdflatex` to process citations
- Verify all citations resolve correctly in the final PDF

### Disclaimer
See [DISCLAIMER.txt](DISCLAIMER.txt) for usage terms and warranty information.

## Support and Resources

### LaTeX Installation
For detailed instructions on installing LaTeX locally:
- [LaTeX-Install.md](LaTeX-Install.md) - English installation guide
- [LaTeX-Install.de.md](LaTeX-Install.de.md) - German installation guide (Deutsche Installationsanleitung)

Both guides cover installation procedures for:
- TeX Live (Linux, macOS, Windows)
- MiKTeX (Windows)
- MacTeX (macOS)

### Getting Help
- **Repository Issues:** Use the [GitHub Issues](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/issues) page to report bugs or request features
- **Pull Requests:** Submit contributions via [Pull Requests](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/pulls)
- **Actions Status:** Monitor build status and download artifacts from the [Actions tab](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions)

### LaTeX Resources
- [LaTeX Project](https://www.latex-project.org/) - Official LaTeX documentation
- [CTAN](https://ctan.org/) - Comprehensive TeX Archive Network for packages
- [Beamer Documentation](https://ctan.org/pkg/beamer) - Guide for presentation slides
- [BibTeX Documentation](http://www.bibtex.org/) - Bibliography management reference

### Security
For security-related concerns, please refer to our [SECURITY.md](SECURITY.md) policy.
