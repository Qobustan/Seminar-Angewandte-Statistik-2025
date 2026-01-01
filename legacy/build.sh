#!/bin/bash
# ==============================================================================
#
#          FILE: build.sh
#
#         USAGE: ./build.sh [TARGET_DIR]
#
#   DESCRIPTION: Build LaTeX documents (Ausarbeitung and Vortrag) for this
#                repository and optionally copy them to a target directory.
#
#       OPTIONS: TARGET_DIR    Optional target directory for output PDFs
#                              If not specified, PDFs remain in their source dirs
#
#  REQUIREMENTS: pdflatex, bibtex
#          BUGS: ---
#         NOTES: This script has been adapted for Seminar-Angewandte-Statistik-2025
#        AUTHOR: ---
#  ORGANIZATION: ---
#       CREATED: ---
#      REVISION: ---
#
# ==============================================================================

set -euo pipefail

# Help function
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [TARGET_DIR]

Build LaTeX documents (Ausarbeitung and Vortrag) for this repository.

ARGUMENTS:
    TARGET_DIR      Optional target directory to copy generated PDFs to.
                    If not specified, PDFs remain in their source directories.

OPTIONS:
    -h, --help      Show this help message and exit

DESCRIPTION:
    This script builds the Ausarbeitung and Vortrag LaTeX documents.
    It runs pdflatex and bibtex as needed to generate the final PDFs.

REQUIREMENTS:
    - pdflatex (from a TeX distribution)
    - bibtex (from a TeX distribution)

EXAMPLES:
    $(basename "$0")                    # Build PDFs in place
    $(basename "$0") /tmp/output        # Build and copy to /tmp/output
    $(basename "$0") --help             # Show this help

EOF
}

# Check for help flag first
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

# Get target directory from argument (optional)
TARGET_DIR="${1:-}"

# Store original directory
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== Building LaTeX Documents ==="
echo ""

# Build Ausarbeitung
echo "[1/2] Building Ausarbeitung..."
cd "$SCRIPT_DIR/Ausarbeitung"
echo "  Running pdflatex (pass 1)..."
pdflatex -interaction=nonstopmode Ausarbeitung.tex > /dev/null
echo "  Running bibtex..."
bibtex Ausarbeitung > /dev/null || true
echo "  Running pdflatex (pass 2)..."
pdflatex -interaction=nonstopmode Ausarbeitung.tex > /dev/null
echo "  Running pdflatex (pass 3)..."
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
cd "$SCRIPT_DIR/Vortrag"
echo "  Running pdflatex (pass 1)..."
pdflatex -interaction=nonstopmode Vortrag.tex > /dev/null
echo "  Running bibtex..."
bibtex Vortrag > /dev/null || true
echo "  Running pdflatex (pass 2)..."
pdflatex -interaction=nonstopmode Vortrag.tex > /dev/null
echo "  Running pdflatex (pass 3)..."
pdflatex -interaction=nonstopmode Vortrag.tex > /dev/null

if [[ -f "Vortrag.pdf" ]]; then
    VORTRAG_SIZE=$(du -h "Vortrag.pdf" | cut -f1)
    echo "  ✓ Vortrag.pdf generated successfully (size: $VORTRAG_SIZE)"
else
    echo "  ✗ Error: Vortrag.pdf was not generated"
    exit 1
fi

# Copy to target directory if specified
if [[ -n "$TARGET_DIR" ]]; then
    echo ""
    echo "Copying PDFs to target directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
    cp "$SCRIPT_DIR/Ausarbeitung/Ausarbeitung.pdf" "$TARGET_DIR/"
    cp "$SCRIPT_DIR/Vortrag/Vortrag.pdf" "$TARGET_DIR/"
    echo "  ✓ Copied Ausarbeitung.pdf"
    echo "  ✓ Copied Vortrag.pdf"
fi

echo ""
echo "=== Build complete ==="
