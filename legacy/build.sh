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
#        AUTHOR: Yavuzâlp Dal
#  ORGANIZATION: ---
#       CREATED: 2025-12-22
#      REVISION: 2026-01-01 - Updated for Seminar-Angewandte-Statistik-2025
#
# ==============================================================================

set -e  # Exit on error

# ------------------------------------------------------------------------------
#  Variables
# ------------------------------------------------------------------------------

VERBOSE=0
CLEAN=0
BUILD_AUSARBEITUNG=1
BUILD_VORTRAG=1

# Determine script directory and repository root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# ------------------------------------------------------------------------------
#  Functions
# ------------------------------------------------------------------------------

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
    
    # First pass: pdflatex
    log "Running pdflatex (first pass)..."
    pdflatex -interaction=nonstopmode "$doc_name.tex" > /dev/null || true
    
    # Run bibtex if .bib file exists
    if [ -f "$doc_name.bib" ]; then
        log "Running bibtex..."
        bibtex "$doc_name" > /dev/null || true
    fi
    
    # Second pass: pdflatex
    log "Running pdflatex (second pass)..."
    pdflatex -interaction=nonstopmode "$doc_name.tex" > /dev/null || true
    
    # Third pass: pdflatex (for references and citations)
    log "Running pdflatex (third pass)..."
    pdflatex -interaction=nonstopmode "$doc_name.tex" > /dev/null || true
    
    # Check if PDF was created
    if [ -f "$doc_name.pdf" ]; then
        echo "✓ Successfully built: $doc_name.pdf"
    else
        error "Failed to build $doc_name.pdf"
    fi
    
    # Clean auxiliary files if requested
    if [ $CLEAN -eq 1 ]; then
        log "Cleaning auxiliary files..."
        rm -f *.aux *.log *.out *.toc *.bbl *.blg *.run.xml *.bcf *.nav *.snm *.synctex.gz 2>/dev/null || true
        echo "✓ Cleaned auxiliary files"
    fi
    
    cd "$REPO_ROOT" || error "Failed to return to repository root"
}

# ------------------------------------------------------------------------------
#  Parse arguments
# ------------------------------------------------------------------------------

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            ;;
        -v|--verbose)
            VERBOSE=1
            shift
            ;;
        -c|--clean)
            CLEAN=1
            shift
            ;;
        -a|--ausarbeitung)
            BUILD_VORTRAG=0
            shift
            ;;
        -p|--presentation)
            BUILD_AUSARBEITUNG=0
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# ------------------------------------------------------------------------------
#  Main build process
# ------------------------------------------------------------------------------

echo "======================================"
echo "  Seminar LaTeX Build Script"
echo "======================================"
echo ""

# Check if LaTeX is installed
if ! command -v pdflatex &> /dev/null; then
    error "pdflatex not found. Please install TeX Live or another LaTeX distribution."
fi

if ! command -v bibtex &> /dev/null; then
    error "bibtex not found. Please install TeX Live or another LaTeX distribution."
fi

log "Repository root: $REPO_ROOT"

# Build Ausarbeitung
if [ $BUILD_AUSARBEITUNG -eq 1 ]; then
    if [ -d "$REPO_ROOT/Ausarbeitung" ]; then
        build_document "$REPO_ROOT/Ausarbeitung" "Ausarbeitung"
        echo ""
    else
        echo "⚠ Warning: Ausarbeitung directory not found, skipping..."
        echo ""
    fi
fi

# Build Vortrag
if [ $BUILD_VORTRAG -eq 1 ]; then
    if [ -d "$REPO_ROOT/Vortrag" ]; then
        build_document "$REPO_ROOT/Vortrag" "Vortrag"
        echo ""
    else
        echo "⚠ Warning: Vortrag directory not found, skipping..."
        echo ""
    fi
fi

echo "======================================"
echo "  Build Complete!"
echo "======================================"

exit 0
