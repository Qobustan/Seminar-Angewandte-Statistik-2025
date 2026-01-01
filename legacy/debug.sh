#!/bin/bash
# ==============================================================================
#
#          FILE: debug.sh
#
#         USAGE: ./debug.sh [OPTIONS]
#
#   DESCRIPTION: Debug script for building Seminar LaTeX documents with verbose
#                output. This is a convenience wrapper around build.sh.
#
#       OPTIONS: Same as build.sh (see build.sh --help)
#  REQUIREMENTS: pdflatex, bibtex (TeX Live or similar LaTeX distribution)
#   DESCRIPTION: Test build script by building PDFs to a debug directory
#
#       OPTIONS: ---
#  REQUIREMENTS: pdflatex, bibtex
#          BUGS: ---
#         NOTES: This script has been adapted for Seminar-Angewandte-Statistik-2025
#        AUTHOR: ---
#  ORGANIZATION: ---
#       CREATED: ---
#      REVISION: 2026-01-01 - Updated for Seminar repository
#
# ==============================================================================

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run build.sh with verbose mode enabled by default
"$SCRIPT_DIR/build.sh" --verbose "$@"
set -euo pipefail

# Help function
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Test the build script by building PDFs to a debug directory.

OPTIONS:
    -h, --help      Show this help message and exit

DESCRIPTION:
    This script tests the build process by calling build.sh and directing
    output to a 'debug' directory in the legacy folder. The debug directory
    will be cleaned and recreated each time this script runs.

REQUIREMENTS:
    - pdflatex (from a TeX distribution)
    - bibtex (from a TeX distribution)
    - build.sh must exist in the same directory

EXAMPLE:
    $(basename "$0")

EOF
}

# Check for help flag
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

echo "=== Debug Build Script ==="
echo ""

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Check if build.sh exists before calling it
if [[ ! -f "$SCRIPT_DIR/build.sh" ]]; then
    echo "Error: build.sh not found in $SCRIPT_DIR"
    echo "This script requires build.sh to be present and executable."
    echo "Run './debug.sh --help' for more information."
    exit 1
fi

if [[ ! -x "$SCRIPT_DIR/build.sh" ]]; then
    echo "Making build.sh executable..."
    chmod +x "$SCRIPT_DIR/build.sh"
fi

echo "Preparing debug directory..."
TARGET_DIR="$SCRIPT_DIR/debug"
rm -rf "$TARGET_DIR" &>/dev/null || true
mkdir -p "$TARGET_DIR"

echo ""
echo "Calling build.sh with target: $TARGET_DIR"
echo ""

"$SCRIPT_DIR/build.sh" "$TARGET_DIR"

echo ""
echo "=== Debug build complete ==="
echo "PDFs copied to: $TARGET_DIR"
if ls "$TARGET_DIR"/*.pdf >/dev/null 2>&1; then
    ls -lh "$TARGET_DIR"/*.pdf
else
    echo "No PDFs found in target directory"
fi
