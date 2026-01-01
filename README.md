```markdown

# Seminar: Angewandte Statistik 2025

This repository contains materials for the "Angewandte Statistik" seminar (2025).

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
- ✅ Clear documentation of branch history and purpose
- ✅ Preserved unique content and configurations
- ✅ Cleaner repository with reduced branch clutter
- ✅ Traceability for future reference
- ✅ Informed deletion decisions

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

[![Build all LaTeX projects](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml)
