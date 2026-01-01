#!/bin/bash
# ==============================================================================
#
#          FILE: Remove_Junk_Linux.sh
#
#   DESCRIPTION: Removes temporary LaTeX build files
#
#       OPTIONS: SHOW_COMMENTS - set to true to show comment output
#
# ==============================================================================

set -euo pipefail

# Kontrollvariable für die Ausgabe von Kommentaren
SHOW_COMMENTS=${SHOW_COMMENTS:-true}

# Function to safely remove files matching patterns
safe_remove() {
    local patterns=("$@")
    local found_files=()
    
    for pattern in "${patterns[@]}"; do
        while IFS= read -r -d '' file; do
            found_files+=("$file")
        done < <(find . -maxdepth 1 -type f -name "$pattern" -print0 2>/dev/null)
    done
    
    if [[ ${#found_files[@]} -gt 0 ]]; then
        rm -f "${found_files[@]}"
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
