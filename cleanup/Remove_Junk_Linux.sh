#!/bin/bash

set -euo pipefail

# Help function
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Remove temporary LaTeX build files from the repository.

OPTIONS:
    -h, --help      Show this help message and exit

DESCRIPTION:
    This script safely removes LaTeX temporary and auxiliary files from
    the current directory and the Ausarbeitung subdirectory.

    Files removed include:
    - Auxiliary files (.aux, .log, .toc, etc.)
    - Bibliography files (.bbl, .blg, .bcf)
    - Index files (.idx, .ind, .ilg, .ist)
    - Glossary files (.glo, .gls, .glg, etc.)
    - Other temporary files (.out, .xml, .gz, .mw)

EXAMPLE:
    ./Remove_Junk_Linux.sh

EOF
}

# Parse command line arguments
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

# Kontrollvariable für die Ausgabe von Kommentaren
SHOW_COMMENTS=true

# Die Dateipfade müsste man anpassen, wenn man das braucht
if [ "$SHOW_COMMENTS" = true ]; then
    echo "# Cleaning temporary LaTeX files from current directory"
fi

# File extensions to remove
EXTENSIONS="aux log lof gz toc bak~ bbl bcf blg lot out xml acn acr alg glg glo gls gug guo gus ist llg llo lls lug luo lus mog moo mos xdy mw"

# Count and remove files in current directory
count=0
for ext in $EXTENSIONS; do
    files_found=$(find . -maxdepth 1 -name "*.$ext" -type f 2>/dev/null || true)
    if [ -n "$files_found" ]; then
        for file in $files_found; do
            rm -f "$file"
            ((count++))
        done
    fi
done

if [ "$SHOW_COMMENTS" = true ]; then
    echo "# Removed $count files from current directory"
fi

# Wechsel in das Verzeichnis 'Ausarbeitung'
if [ "$SHOW_COMMENTS" = true ]; then
    echo "# Changing to 'Ausarbeitung' directory"
fi

# Check if Ausarbeitung directory exists
if [ -d "Ausarbeitung" ]; then
    cd Ausarbeitung
    
    # Löschen der gleichen temporären Dateien im Zielverzeichnis
    if [ "$SHOW_COMMENTS" = true ]; then
        echo "# Cleaning temporary LaTeX files from Ausarbeitung directory"
    fi
    
    # Count and remove files in Ausarbeitung directory
    ausarbeitung_count=0
    for ext in $EXTENSIONS; do
        files_found=$(find . -maxdepth 1 -name "*.$ext" -type f 2>/dev/null || true)
        if [ -n "$files_found" ]; then
            for file in $files_found; do
                rm -f "$file"
                ((ausarbeitung_count++))
            done
        fi
    done
    
    if [ "$SHOW_COMMENTS" = true ]; then
        echo "# Removed $ausarbeitung_count files from Ausarbeitung directory"
    fi
    
    total=$((count + ausarbeitung_count))
    echo ""
    echo "=== Cleanup complete ==="
    echo "Total files removed: $total"
else
    if [ "$SHOW_COMMENTS" = true ]; then
        echo "# Warning: Ausarbeitung directory not found, skipping"
    fi
    echo ""
    echo "=== Cleanup complete ==="
    echo "Total files removed: $count"
fi
