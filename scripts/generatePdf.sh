#!/bin/bash
# Script to generate PDFs for Ausarbeitung and Vortrag

set -euo pipefail

# Help function
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Generate PDFs for Ausarbeitung and Vortrag using pdflatex (or lualatex) and bibtex.

OPTIONS:
    -h, --help      Show this help message and exit

DESCRIPTION:
    This script compiles LaTeX documents in the Ausarbeitung and Vortrag
    directories. It runs the LaTeX engine three times and bibtex once for each
    document to ensure all references and cross-references are resolved.
    
    By default, pdflatex is used for backwards compatibility. To use lualatex
    instead, set the LATEX_ENGINE environment variable:
    
        LATEX_ENGINE=lualatex ./scripts/generatePdf.sh

REQUIREMENTS:
    - pdflatex (from a TeX distribution) - default
    - lualatex (from a TeX distribution) - optional
    - bibtex (from a TeX distribution)

EXAMPLES:
    # Use default pdflatex
    ./scripts/generatePdf.sh
    
    # Use lualatex instead
    LATEX_ENGINE=lualatex ./scripts/generatePdf.sh

EOF
}

# Parse command line arguments
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

# Determine which LaTeX engine to use (default: pdflatex for backwards compatibility)
LATEX_ENGINE="${LATEX_ENGINE:-pdflatex}"

# Validate and normalize the engine name (case-insensitive to match generatePdf.bat behavior)
LATEX_ENGINE_LOWER="${LATEX_ENGINE,,}"
case "${LATEX_ENGINE_LOWER}" in
    pdflatex|lualatex)
        # Valid engine - use normalized lowercase version
        LATEX_ENGINE="${LATEX_ENGINE_LOWER}"
        ;;
    *)
        echo "Error: Invalid LATEX_ENGINE '${LATEX_ENGINE}'"
        echo "Supported engines: pdflatex, lualatex"
        echo "Defaulting to pdflatex for backwards compatibility"
        LATEX_ENGINE="pdflatex"
        ;;
esac

# Check if required tools are installed
if ! command -v "${LATEX_ENGINE}" &> /dev/null; then
    echo "Error: ${LATEX_ENGINE} is not installed or not in PATH"
    echo "Please install a TeX distribution (e.g., TeX Live, MiKTeX)"
    exit 1
fi

if ! command -v bibtex &> /dev/null; then
    echo "Error: bibtex is not installed or not in PATH"
    echo "Please install a TeX distribution (e.g., TeX Live, MiKTeX)"
    exit 1
fi

echo "=== PDF Generation Script ==="
echo "Using LaTeX engine: ${LATEX_ENGINE}"
echo ""

# Build Ausarbeitung
echo "[1/2] Building Ausarbeitung..."
cd "$(dirname "$0")/../Ausarbeitung"
echo "  Step 1/4: Running ${LATEX_ENGINE} (first pass)..."
"${LATEX_ENGINE}" -interaction=nonstopmode Ausarbeitung.tex > /dev/null
echo "  Step 2/4: Running bibtex..."
bibtex Ausarbeitung > /dev/null || true
echo "  Step 3/4: Running ${LATEX_ENGINE} (second pass)..."
"${LATEX_ENGINE}" -interaction=nonstopmode Ausarbeitung.tex > /dev/null
echo "  Step 4/4: Running ${LATEX_ENGINE} (third pass)..."
"${LATEX_ENGINE}" -interaction=nonstopmode Ausarbeitung.tex > /dev/null

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
echo "  Step 1/4: Running ${LATEX_ENGINE} (first pass)..."
"${LATEX_ENGINE}" -interaction=nonstopmode Vortrag.tex > /dev/null
echo "  Step 2/4: Running bibtex..."
bibtex Vortrag > /dev/null || true
echo "  Step 3/4: Running ${LATEX_ENGINE} (second pass)..."
"${LATEX_ENGINE}" -interaction=nonstopmode Vortrag.tex > /dev/null
echo "  Step 4/4: Running ${LATEX_ENGINE} (third pass)..."
"${LATEX_ENGINE}" -interaction=nonstopmode Vortrag.tex > /dev/null

if [[ -f "Vortrag.pdf" ]]; then
    VORTRAG_SIZE=$(du -h "Vortrag.pdf" | cut -f1)
    echo "  ✓ Vortrag.pdf generated successfully (size: $VORTRAG_SIZE)"
else
    echo "  ✗ Error: Vortrag.pdf was not generated"
    exit 1
fi

echo ""
echo "=== All PDFs generated successfully! ==="