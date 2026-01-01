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
├── cleanup/           # Cleanup and maintenance scripts
├── legacy/            # Legacy files and historical code
├── archive/           # Historical branch documentation
└── .github/workflows/ # CI/CD automation
```

### Directory Details
- **Ausarbeitung/:** Main written elaboration with LaTeX sources and bibliography
- **Vortrag/:** Presentation slides using Beamer class
- **Besprechung/:** Discussion materials and meeting notes
- **scripts/:** Build automation scripts (including `generatePdf.sh`)
- **task_skripts/:** Task-specific helper scripts
- **cleanup/:** Scripts for cleaning temporary and auxiliary LaTeX files
- **legacy/:** Archived or deprecated content for reference (includes legacy build scripts)
- **archive/:** Historical branch documentation and unique content preservation (see [`archive/README.md`](archive/README.md))
- **.github/workflows/:** CI/CD automation workflows

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
- Uses `ChkTeX` to detect common LaTeX errors and style issues
- Helps maintain consistent LaTeX code quality

#### LaTeX Formatting
**Workflow:** [format.yml](.github/workflows/format.yml)
- Available for manual trigger only
- Uses `latexindent` to format LaTeX source files
- Automatically formats all `.tex` files in the repository

#### Bibliography Validation
**Workflow:** [bibcheck.yml](.github/workflows/bibcheck.yml)
- Runs automatically on all pushes and pull requests
- Checks `.bib` bibliography files for duplicate entries
- Helps catch common bibliography formatting issues

#### Docker Image Build
**Workflow:** [docker-image.yml](.github/workflows/docker-image.yml)
- Runs on pushes to `main` and on pull requests
- Builds Docker image to ensure it compiles successfully
- Provides a reproducible LaTeX compilation environment

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

**latexindent** - LaTeX formatter:
```bash
latexindent -w Ausarbeitung/Ausarbeitung.tex
latexindent -w Vortrag/Vortrag.tex
```

**cspell** - Spell checker:
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
- **scripts/generatePdf.sh:** Script for generating PDFs from LaTeX sources
- **cleanup/:** Scripts for cleaning temporary and auxiliary LaTeX files
- **legacy/build.sh:** Legacy build script for web application deployment (not used for current LaTeX compilation)
- **legacy/debug.sh:** Legacy debugging script for web application builds (not used for LaTeX compilation)

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
