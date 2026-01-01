#!/bin/bash
# Script to generate PDFs for Ausarbeitung and Vortrag

set -e

echo "Building Ausarbeitung..."
cd "$(dirname "$0")/../Ausarbeitung"
pdflatex -interaction=nonstopmode Ausarbeitung.tex
bibtex Ausarbeitung || true
pdflatex -interaction=nonstopmode Ausarbeitung.tex
pdflatex -interaction=nonstopmode Ausarbeitung.tex

echo "Building Vortrag..."
cd ../Vortrag
pdflatex -interaction=nonstopmode Vortrag.tex
bibtex Vortrag || true
pdflatex -interaction=nonstopmode Vortrag.tex
pdflatex -interaction=nonstopmode Vortrag.tex

echo "PDFs generated successfully!"