#!/bin/bash
# ==============================================================================
#
#          FILE: build.sh
#
#         USAGE: ./build.sh [OPTIONS]
#
#   DESCRIPTION: Build script for Seminar LaTeX documents (Ausarbeitung and Vortrag)
#                This script compiles the LaTeX documents into PDFs
#
#       OPTIONS: 
#                -h, --help         Show this help message
#                -v, --verbose      Enable verbose output
#                -c, --clean        Clean auxiliary files after build
#                -a, --ausarbeitung Build only Ausarbeitung
#                -p, --presentation Build only Vortrag (presentation)
#
#  REQUIREMENTS: pdflatex, bibtex (TeX Live or similar LaTeX distribution)
#        AUTHOR: Yavuzalp Dal
#       CREATED: 2026-01-01
#
# ==============================================================================

set -e

VERBOSE=0
CLEAN=0
BUILD_AUSARBEITUNG=1
BUILD_VORTRAG=1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

function show_help {
    cat << EOF
Usage: $0 [OPTIONS]

Build script for Seminar LaTeX documents.

OPTIONS:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose output
    -c, --clean         Clean auxiliary files after build
    -a, --ausarbeitung  Build only Ausarbeitung (written report)
    -p, --presentation  Build only Vortrag (presentation)

EXAMPLES:
    $0                  Build both Ausarbeitung and Vortrag
    $0 -v -c            Build both with verbose output and cleanup
    $0 -a               Build only Ausarbeitung
    $0 -p -v            Build only Vortrag with verbose output

EOF
    exit 0
}

function log {
    if [ $VERBOSE -eq 1 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    fi
}

function error {
    echo "[ERROR] $1" >&2
    exit 1
}

function build_document {
    local doc_dir="$1"
    local doc_name="$2"
    
    echo "Building $doc_name..."
    log "Entering directory: $doc_dir"
    
    cd "$doc_dir" || error "Failed to change to directory: $doc_dir"
    
    log "Running pdflatex (first pass)..."
    pdflatex -interaction=nonstopmode "$doc_name.tex" > /dev/null 2>&1 || true
    
    log "Running bibtex..."
    bibtex "$doc_name" > /dev/null 2>&1 || true
    
    log "Running pdflatex (second pass)..."
    pdflatex -interaction=nonstopmode "$doc_name.tex" > /dev/null 2>&1 || true
    
    log "Running pdflatex (third pass)..."
    pdflatex -interaction=nonstopmode "$doc_name.tex" > /dev/null 2>&1 || true
    
    if [ -f "$doc_name.pdf" ]; then
        echo "✓ Successfully built: $doc_name.pdf"
    else
        error "Failed to build $doc_name.pdf"
    fi
    
    if [ $CLEAN -eq 1 ]; then
        log "Cleaning auxiliary files..."
        rm -f *.aux *.log *.out *.toc *.bbl *.blg *.run.xml *.bcf *.nav *.snm *.synctex.gz 2>/dev/null || true
        echo "✓ Cleaned auxiliary files"
    fi
    
    cd "$REPO_ROOT" || error "Failed to return to repository root"
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) show_help ;;
        -v|--verbose) VERBOSE=1; shift ;;
        -c|--clean) CLEAN=1; shift ;;
        -a|--ausarbeitung) BUILD_VORTRAG=0; shift ;;
        -p|--presentation) BUILD_AUSARBEITUNG=0; shift ;;
        *) echo "Unknown option: $1"; echo "Use -h for help"; exit 1 ;;
    esac
done

echo "======================================"
echo "  Seminar LaTeX Build Script"
echo "======================================"
echo ""

if ! command -v pdflatex &> /dev/null; then
    error "pdflatex not found. Please install TeX Live."
fi

if ! command -v bibtex &> /dev/null; then
    error "bibtex not found. Please install TeX Live."
fi

log "Repository root: $REPO_ROOT"

if [ $BUILD_AUSARBEITUNG -eq 1 ]; then
    if [ -d "$REPO_ROOT/Ausarbeitung" ]; then
        build_document "$REPO_ROOT/Ausarbeitung" "Ausarbeitung"
        echo ""
    else
        echo "Warning: Ausarbeitung directory not found, skipping..."
    fi
fi

if [ $BUILD_VORTRAG -eq 1 ]; then
    if [ -d "$REPO_ROOT/Vortrag" ]; then
        build_document "$REPO_ROOT/Vortrag" "Vortrag"
        echo ""
    else
        echo "Warning: Vortrag directory not found, skipping..."
    fi
fi

echo "======================================"
echo "  Build Complete!"
echo "======================================"

exit 0
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
