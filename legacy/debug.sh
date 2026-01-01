#!/bin/bash
# ==============================================================================
#
#          FILE: debug.sh
#
#         USAGE: ./debug.sh
#
#   DESCRIPTION: This script builds the web application in a local directory
#                named 'debug'.
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Yavuzâlp Dal
#  ORGANIZATION: ---
#       CREATED: ---
#      REVISION: ---
#
# ==============================================================================

set -euo pipefail

# Help function
show_help() {
    cat << EOF
⚠️  WARNING: THIS SCRIPT IS NOT COMPATIBLE WITH THIS REPOSITORY! ⚠️

This script (debug.sh) was designed for a different repository
(fhswf/LaTeX-Editor-source) and will NOT work in this repository.

ORIGINAL USAGE (for reference only):
    ./debug.sh

DESCRIPTION (for reference only):
    This script would build a web application in a local 'debug' directory
    by calling build.sh with test parameters.

FOR THIS REPOSITORY, USE INSTEAD:
    scripts/generatePdf.sh    - Generate PDFs for Ausarbeitung and Vortrag

This file is kept in legacy/ directory for historical reference only.

EOF
}

# Check for help flag
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

echo "=== Debug Build Script ==="
echo ""
echo "⚠️  WARNING: This script is not compatible with this repository!"
echo "   It was designed for fhswf/LaTeX-Editor-source"
echo ""
echo "Checking for build.sh..."

# Check if build.sh exists before calling it
if [[ ! -f "./build.sh" ]]; then
    echo "Error: build.sh not found in current directory"
    echo ""
    echo "This script requires build.sh to be present and executable."
    echo "Run './debug.sh --help' for more information."
    exit 1
fi

if [[ ! -x "./build.sh" ]]; then
    echo "Warning: build.sh is not executable, attempting to make it executable..."
    chmod +x ./build.sh
fi

echo "Preparing debug directory..."
TARGET_DIR=debug
rm -rf "$TARGET_DIR" &>/dev/null && mkdir "$TARGET_DIR"

echo "Calling build.sh..."
./build.sh "$TARGET_DIR" gituser/example-repo latex.example.net

echo ""
echo "=== Build complete ==="
