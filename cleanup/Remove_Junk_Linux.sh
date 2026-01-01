#!/bin/bash
# ==============================================================================
#
#          FILE: Remove_Junk_Linux.sh
#
#   DESCRIPTION: Removes temporary LaTeX build files
#
#       OPTIONS: SHOW_COMMENTS - set to true to show comment output
#                -h, --help    - show usage information
#
# ==============================================================================

set -euo pipefail

# Show help if requested
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    cat << EOF
Usage: $0

Description:
    Removes temporary LaTeX build files from the current directory
    and the 'Ausarbeitung' subdirectory.

Environment Variables:
    SHOW_COMMENTS    Set to 'false' to suppress informational messages (default: true)

Example:
    $0
    SHOW_COMMENTS=false $0

EOF
    exit 0
fi

# Kontrollvariable für die Ausgabe von Kommentaren
SHOW_COMMENTS=${SHOW_COMMENTS:-true}

# Function to safely remove files matching patterns
safe_remove() {
    local patterns=("$@")
    local found_files=()
    local count=0
    
    for pattern in "${patterns[@]}"; do
        while IFS= read -r -d '' file; do
            found_files+=("$file")
            ((count++))
        done < <(find . -maxdepth 1 -type f -name "$pattern" -print0 2>/dev/null)
    done
    
    if [[ ${#found_files[@]} -gt 0 ]]; then
        rm -f "${found_files[@]}"
        [[ "$SHOW_COMMENTS" == "true" ]] && echo "  Removed $count file(s)"
    else
        [[ "$SHOW_COMMENTS" == "true" ]] && echo "  No files to remove"
    fi
}

# Die Dateipfade müsste man anpassen, wenn man das braucht
if [[ "$SHOW_COMMENTS" == "true" ]]; then
    echo "# Removing temporary LaTeX files in current directory"
fi

# Define file patterns to remove
temp_patterns=(
    "*.aux" "*.log" "*.lof" "*.gz" "*.toc" "*.bak~" "*.bbl" "*.bcf" 
    "*.blg" "*.lot" "*.out" "*.xml" "*.acn" "*.acr" "*.alg" "*.glg" 
    "*.glo" "*.gls" "*.gug" "*.guo" "*.gus" "*.ist" "*.llg" "*.llo" 
    "*.lls" "*.lug" "*.luo" "*.lus" "*.mog" "*.moo" "*.mos" "*.xdy" "*.mw"
)

safe_remove "${temp_patterns[@]}"

# Wechsel in das Verzeichnis 'Ausarbeitung'
if [[ "$SHOW_COMMENTS" == "true" ]]; then
    echo "# Changing to directory 'Ausarbeitung'"
fi

if [[ -d "Ausarbeitung" ]]; then
    cd Ausarbeitung
    
    # Löschen der gleichen temporären Dateien im Zielverzeichnis
    if [[ "$SHOW_COMMENTS" == "true" ]]; then
        echo "# Removing temporary LaTeX files in Ausarbeitung directory"
    fi
    
    safe_remove "${temp_patterns[@]}"
else
    if [[ "$SHOW_COMMENTS" == "true" ]]; then
        echo "# Warning: Directory 'Ausarbeitung' not found, skipping"
    fi
fi
