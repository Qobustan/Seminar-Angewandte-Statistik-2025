#!/bin/bash
# Script to generate PDFs for Ausarbeitung and Vortrag

set -euo pipefail

# Help function
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Generate PDFs for Ausarbeitung and Vortrag using pdflatex and bibtex.

OPTIONS:
    -h, --help      Show this help message and exit

DESCRIPTION:
    This script compiles LaTeX documents in the Ausarbeitung and Vortrag
    directories. It runs pdflatex three times and bibtex once for each
    document to ensure all references and cross-references are resolved.

REQUIREMENTS:
    - pdflatex (from a TeX distribution)
    - bibtex (from a TeX distribution)

EXAMPLE:
    ./generatePdf.sh

EOF
}

# Parse command line arguments
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

# Check if required tools are installed
if ! command -v pdflatex &> /dev/null; then
    echo "Error: pdflatex is not installed or not in PATH"
    echo "Please install a TeX distribution (e.g., TeX Live, MiKTeX)"
    exit 1
fi

if ! command -v bibtex &> /dev/null; then
    echo "Error: bibtex is not installed or not in PATH"
    echo "Please install a TeX distribution (e.g., TeX Live, MiKTeX)"
    exit 1
fi

echo "=== PDF Generation Script ==="
echo ""

# Build Ausarbeitung
echo "[1/2] Building Ausarbeitung..."
cd "$(dirname "$0")/../Ausarbeitung"
echo "  Step 1/4: Running pdflatex (first pass)..."
pdflatex -interaction=nonstopmode Ausarbeitung.tex > /dev/null
echo "  Step 2/4: Running bibtex..."
bibtex Ausarbeitung > /dev/null || true
echo "  Step 3/4: Running pdflatex (second pass)..."
pdflatex -interaction=nonstopmode Ausarbeitung.tex > /dev/null
echo "  Step 4/4: Running pdflatex (third pass)..."
pdflatex -interaction=nonstopmode Ausarbeitung.tex > /dev/null

if [[ -f "Ausarbeitung.pdf" ]]; then
    AUSARBEITUNG_SIZE=$(du -h "Ausarbeitung.pdf" | cut -f1)
    echo "  ✓ Ausarbeitung.pdf generated successfully (size: $AUSARBEITUNG_SIZE)"
else
    echo "  ✗ Error: Ausarbeitung.pdf was not generated"
    exit 1
fi

# Build Vortrag
echo ""
echo "[2/2] Building Vortrag..."
cd ../Vortrag
echo "  Step 1/4: Running pdflatex (first pass)..."
pdflatex -interaction=nonstopmode Vortrag.tex > /dev/null
echo "  Step 2/4: Running bibtex..."
bibtex Vortrag > /dev/null || true
echo "  Step 3/4: Running pdflatex (second pass)..."
pdflatex -interaction=nonstopmode Vortrag.tex > /dev/null
echo "  Step 4/4: Running pdflatex (third pass)..."
pdflatex -interaction=nonstopmode Vortrag.tex > /dev/null

if [[ -f "Vortrag.pdf" ]]; then
    VORTRAG_SIZE=$(du -h "Vortrag.pdf" | cut -f1)
    echo "  ✓ Vortrag.pdf generated successfully (size: $VORTRAG_SIZE)"
else
    echo "  ✗ Error: Vortrag.pdf was not generated"
    exit 1
fi

echo ""
echo "=== All PDFs generated successfully! ==="