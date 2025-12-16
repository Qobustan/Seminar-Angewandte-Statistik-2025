```markdown

# Seminar: Angewandte Statistik 2025

This repository contains materials for the "Angewandte Statistik" seminar (2025).

Structure
- skript/ — main LaTeX sources for the seminar script
- presentation/ — LaTeX sources for the seminar presentation

CI
A GitHub Actions workflow is provided (.github/workflows/build-and-publish-pdfs.yml).
On pushes to main (and when manually triggered) it:
- installs a minimal TeX Live setup
- builds PDFs from the first .tex file found in skript/ and presentation/ using latexmk with PDFLaTeX
- collects the generated PDFs and publishes them to a dedicated branch named 'pdfs'

Usage
- Edit the LaTeX sources in skript/ and presentation/ and push to main.
The workflow will automatically build and update the 'pdfs' branch with the generated PDFs.

Notes
- The workflow looks for the first .tex file in each directory.
If you use other filenames, ensure the main document is the first .tex file in the directory (or modify the workflow to point to the correct root files).
- The workflow installs a subset of TeX Live packages (mainly pdflatex and dependencies) which are necessary for this project and shall be sufficient for many documents using PDFLaTeX.
If your project depends on other packages, update the workflow to install additional texlive packages or a fuller TeX Live distribution.

```

[![Build all LaTeX projects](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml/badge.svg)](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions/workflows/build-and-publish-pdfs.yml)
