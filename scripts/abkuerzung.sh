#!/bin/bash
# ==============================================================================
#
#          FILE: abkuerzung.sh
#
#   DESCRIPTION: Updates abbreviations index using makeindex
#
#       USAGE: ./abkuerzung.sh [-h|--help]
#
#       OPTIONS: -h, --help    Show usage information
#
# ==============================================================================

set -euo pipefail

# Show help if requested
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    cat << EOF
Usage: $0

Description:
    Updates abbreviations index for the LaTeX document using makeindex.
    Processes the .nlo file and generates the .nls file.

Requirements:
    - ../src/Hauptdatei.nlo must exist (run pdflatex first)
    - ../src/latex_einstellungen/abkuezungen/nomencl.ist must exist

Example:
    $0

EOF
    exit 0
fi

# Check if makeindex is available
if ! command -v makeindex &> /dev/null; then
    echo "Error: makeindex command not found" >&2
    echo "Please install a LaTeX distribution that includes makeindex" >&2
    exit 1
fi

# Check if required directories and files exist
if [[ ! -d "../src" ]]; then
    echo "Error: ../src directory not found" >&2
    exit 1
fi

if [[ ! -f "../src/Hauptdatei.nlo" ]]; then
    echo "Error: ../src/Hauptdatei.nlo not found" >&2
    echo "Please run pdflatex first to generate the .nlo file" >&2
    exit 1
fi

if [[ ! -f "../src/latex_einstellungen/abkuezungen/nomencl.ist" ]]; then
    echo "Error: nomencl.ist style file not found" >&2
    exit 1
fi

# Run makeindex to update abbreviations
echo "Updating abbreviations..."
makeindex ../src/Hauptdatei.nlo \
    -s ../src/latex_einstellungen/abkuezungen/nomencl.ist \
    -o ../src/Hauptdatei.nls

echo "Abbreviations updated successfully"
