# Seminar: Angewandte Statistik 2025

[![Build all LaTeX projects](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml)

Welcome to the repository for the **Angewandte Statistik** seminar (2025). This repository contains all materials for the seminar, including written elaborations and presentation slides.

## 📁 Repository Structure

```
.
├── Ausarbeitung/       # Written elaboration (LaTeX sources)
├── Vortrag/           # Presentation slides (Beamer LaTeX sources)
├── Besprechung/       # Discussion materials
├── scripts/           # Build and utility scripts
├── task_skripts/      # Task-specific scripts
└── .github/workflows/ # CI/CD automation
```

## 🚀 Quick Start

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
cd Ausarbeitung && latexmk -pdf Ausarbeitung.tex
cd Vortrag && latexmk -pdf Vortrag.tex
```

## 🔄 Continuous Integration

This repository uses GitHub Actions for automated PDF generation. 

**Workflow:** [build-and-publish-pdfs.yml](.github/workflows/build-and-publish-pdfs.yml)

On every push to `main` (or when manually triggered):
1. Compiles `Ausarbeitung.tex` from the `Ausarbeitung/` directory
2. Compiles `Vortrag.tex` from the `Vortrag/` directory  
3. Uploads generated PDFs as build artifacts

### Downloading PDFs

After each successful build, the generated PDFs are available as artifacts:
1. Go to the [Actions tab](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions)
2. Click on the latest successful workflow run
3. Download the `latex-pdfs` artifact

## 🛠️ Development

### Editing LaTeX Sources

- **Ausarbeitung:** Edit `Ausarbeitung/Ausarbeitung.tex` for the written paper
- **Vortrag:** Edit `Vortrag/Vortrag.tex` for the presentation slides

Both directories include a `header.tex` file for shared preamble configurations.

### Adding Dependencies

If your LaTeX documents require additional packages, update the GitHub Actions workflow to include them. The workflow uses the [xu-cheng/latex-action](https://github.com/xu-cheng/latex-action) which includes a comprehensive TeX Live distribution.

## 📋 Additional Files

- **DISCLAIMER.txt:** General disclaimer and warranty information
- **SECURITY.md:** Security policy and vulnerability reporting
- **Dockerfile:** Container definition for reproducible builds
- **build.sh:** Build script for local compilation
- **debug.sh:** Debugging utilities

## 🤝 Contributing

1. Create a feature branch from `main`
2. Make your changes
3. Test locally to ensure PDFs compile correctly
4. Push your changes and create a pull request
5. Wait for CI to verify your changes

## ⚠️ Important Notes

- The CI workflow automatically builds PDFs on push to `main`
- Build artifacts are retained for 90 days by default
- Make sure your LaTeX sources compile without errors before pushing
- See [DISCLAIMER.txt](DISCLAIMER.txt) for usage terms

## 📞 Support

For LaTeX installation help, refer to:
- [LaTeX-Install.md](LaTeX-Install.md) (English)
- [LaTeX-Install.de.md](LaTeX-Install.de.md) (German)

For repository issues, please use the [GitHub Issues](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/issues) page.
