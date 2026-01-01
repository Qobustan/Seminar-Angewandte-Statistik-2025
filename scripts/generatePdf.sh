#!/bin/bash
# Script to generate PDFs for Ausarbeitung and Vortrag

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Build Ausarbeitung
echo "Building Ausarbeitung..."
cd "$REPO_ROOT/Ausarbeitung"
pdflatex -interaction=nonstopmode Ausarbeitung.tex
bibtex Ausarbeitung || true
pdflatex -interaction=nonstopmode Ausarbeitung.tex
pdflatex -interaction=nonstopmode Ausarbeitung.tex

# Build Vortrag
echo "Building Vortrag..."
cd "$REPO_ROOT/Vortrag"
pdflatex -interaction=nonstopmode Vortrag.tex
bibtex Vortrag || true
pdflatex -interaction=nonstopmode Vortrag.tex
pdflatex -interaction=nonstopmode Vortrag.tex

echo "PDF generation complete!"