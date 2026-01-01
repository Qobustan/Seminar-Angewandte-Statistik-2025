#!/bin/bash
# ==============================================================================
#
#          FILE: generatePdf.sh
#
#   DESCRIPTION: Generates PDF from LaTeX source with proper compilation steps
#
#       USAGE: ./generatePdf.sh [-h|--help]
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
    Generates PDF from LaTeX source with proper compilation steps.
    Runs pdflatex, bibtex, makeindex, and pdflatex again (3 passes total).
    Automatically cleans up temporary files after compilation.

Requirements:
    - ../src/Hauptdatei.tex must exist
    - pdflatex, bibtex, and makeindex must be available

Example:
    $0

EOF
    exit 0
fi

# Check if required LaTeX commands are available
for cmd in pdflatex bibtex makeindex; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd command not found" >&2
        echo "Please install a LaTeX distribution that includes $cmd" >&2
        exit 1
    fi
done

# Check if source directory exists
if [[ ! -d "../src" ]]; then
    echo "Error: ../src directory not found" >&2
    exit 1
fi

cd ../src

# Check if main file exists
if [[ ! -f "Hauptdatei.tex" ]]; then
    echo "Error: Hauptdatei.tex not found" >&2
    exit 1
fi

echo "Starting PDF generation process..."
echo "======================================"

# 1. Generiert das Dokument mit Fragezeichen anstelle von Zitaten
echo "Step 1/5: Running pdflatex (first pass)..."
pdflatex -interaction=nonstopmode Hauptdatei.tex || {
    echo "Warning: pdflatex first pass completed with warnings" >&2
}

# 2. Dies wird die .bib Datei verarbeiten, und das Dokument mit Zitatinformationen anreichern
echo "Step 2/5: Running bibtex..."
if [[ -f "Hauptdatei.aux" ]]; then
    bibtex Hauptdatei || {
        echo "Warning: bibtex completed with warnings" >&2
    }
else
    echo "Warning: Hauptdatei.aux not found, skipping bibtex" >&2
fi

# 3. aktualisiert den Index
echo "Step 3/5: Running makeindex..."
if [[ -f "Hauptdatei.nlo" ]] && [[ -f "latex_einstellungen/abkuezungen/nomencl.ist" ]]; then
    makeindex Hauptdatei.nlo -s latex_einstellungen/abkuezungen/nomencl.ist -o Hauptdatei.nls || {
        echo "Warning: makeindex completed with warnings" >&2
    }
else
    echo "Warning: Abbreviation files not found, skipping makeindex" >&2
fi

# 4. Verarbeitet die Dateien nochmals und inkludiert die Zitate
echo "Step 4/5: Running pdflatex (second pass)..."
pdflatex -interaction=nonstopmode Hauptdatei.tex || {
    echo "Warning: pdflatex second pass completed with warnings" >&2
}

# 5. nochmal, um sicher zu gehen, u.a. falls sich durch die Zitate die Seitennummerierung geändert hat
echo "Step 5/5: Running pdflatex (third pass)..."
pdflatex -interaction=nonstopmode Hauptdatei.tex || {
    echo "Warning: pdflatex third pass completed with warnings" >&2
}

# Aufräumen...
echo ""
echo "======================================"
echo "Cleaning up temporary files..."
# Define patterns of files to remove
temp_files=(
    "*.aux" "*.dvi" "*.log" "*.lot" "*.lol" "*.lof" "*.nls" "*.ilg" 
    "*.nlo" "*.idx" "*.out" "*.toc" "*.ist" "*.glo" "*.blg"
)

for pattern in "${temp_files[@]}"; do
    find . -maxdepth 1 -type f -name "$pattern" -delete 2>/dev/null || true
done

# Clean up latex_einstellungen directory
if [[ -d "latex_einstellungen" ]]; then
    find latex_einstellungen -maxdepth 1 -type f -name "*.aux" -delete 2>/dev/null || true
fi

echo "======================================"
echo "PDF generation completed successfully!"
if [[ -f "Hauptdatei.pdf" ]]; then
    echo "Output file: $(pwd)/Hauptdatei.pdf"
    echo "File size: $(du -h Hauptdatei.pdf | cut -f1)"
fi