#!/bin/bash
# ==============================================================================
#
#          FILE: abkuerzung.sh
#
#   DESCRIPTION: Updates abbreviations index using makeindex
#
#       USAGE: ./abkuerzung.sh
#
# ==============================================================================

set -euo pipefail

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
makeindex ../src/Hauptdatei.nlo \
    -s ../src/latex_einstellungen/abkuezungen/nomencl.ist \
    -o ../src/Hauptdatei.nls

echo "Abbreviations updated successfully"
