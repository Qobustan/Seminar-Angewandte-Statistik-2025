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
    the current directory, Ausarbeitung, and Vortrag subdirectories.

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
EXTENSIONS="aux log lof gz toc bak~ bbl bcf blg lot out xml acn acr alg glg glo gls gug guo gus ist llg llo lls lug luo lus mog moo mos xdy mw nav snm"

# Get the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Count and remove files in current directory
count=0
for ext in $EXTENSIONS; do
    files_found=$(find . -maxdepth 1 -name "*.$ext" -type f 2>/dev/null || true)
    if [ -n "$files_found" ]; then
        for file in $files_found; do
            rm -f "$file"
            count=$((count + 1))
        done
    fi
done

if [ "$SHOW_COMMENTS" = true ]; then
    echo "# Removed $count files from current directory"
fi

# Total count
total=$count

# Clean Ausarbeitung directory
if [ "$SHOW_COMMENTS" = true ]; then
    echo "# Cleaning 'Ausarbeitung' directory"
fi

if [ -d "$REPO_ROOT/Ausarbeitung" ]; then
    cd "$REPO_ROOT/Ausarbeitung"
    
    if [ "$SHOW_COMMENTS" = true ]; then
        echo "# Cleaning temporary LaTeX files from Ausarbeitung directory"
    fi
    
    ausarbeitung_count=0
    for ext in $EXTENSIONS; do
        files_found=$(find . -maxdepth 1 -name "*.$ext" -type f 2>/dev/null || true)
        if [ -n "$files_found" ]; then
            for file in $files_found; do
                rm -f "$file"
                ausarbeitung_count=$((ausarbeitung_count + 1))
            done
        fi
    done
    
    if [ "$SHOW_COMMENTS" = true ]; then
        echo "# Removed $ausarbeitung_count files from Ausarbeitung directory"
    fi
    
    total=$((total + ausarbeitung_count))
else
    if [ "$SHOW_COMMENTS" = true ]; then
        echo "# Warning: Ausarbeitung directory not found, skipping"
    fi
fi

# Clean Vortrag directory
if [ "$SHOW_COMMENTS" = true ]; then
    echo "# Cleaning 'Vortrag' directory"
fi

if [ -d "$REPO_ROOT/Vortrag" ]; then
    cd "$REPO_ROOT/Vortrag"
    
    if [ "$SHOW_COMMENTS" = true ]; then
        echo "# Cleaning temporary LaTeX files from Vortrag directory"
    fi
    
    vortrag_count=0
    for ext in $EXTENSIONS; do
        files_found=$(find . -maxdepth 1 -name "*.$ext" -type f 2>/dev/null || true)
        if [ -n "$files_found" ]; then
            for file in $files_found; do
                rm -f "$file"
                vortrag_count=$((vortrag_count + 1))
            done
        fi
    done
    
    if [ "$SHOW_COMMENTS" = true ]; then
        echo "# Removed $vortrag_count files from Vortrag directory"
    fi
    
    total=$((total + vortrag_count))
else
    if [ "$SHOW_COMMENTS" = true ]; then
        echo "# Warning: Vortrag directory not found, skipping"
    fi
fi

echo ""
echo "=== Cleanup complete ==="
echo "Total files removed: $total"
