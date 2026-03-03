#!/bin/bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
#
# Startet Docker: Baut das Image und erzeugt die PDFs im Container.
#
# Verwendung:
#   ./bin/docker.sh [--lualatex]
#
# Optionen:
#   --lualatex   LuaLaTeX statt pdflatex verwenden
#   -h, --help   Diese Hilfe anzeigen

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

show_help() {
    cat << EOF
Verwendung: $(basename "$0") [--lualatex]

Baut das Docker-Image und generiert die PDFs im Container.

Optionen:
  --lualatex   LuaLaTeX statt pdflatex verwenden
  -h, --help   Diese Hilfe anzeigen

Beispiele:
  ./bin/docker.sh
  ./bin/docker.sh --lualatex
EOF
}

LATEX_ENGINE="pdflatex"
for arg in "$@"; do
    case "$arg" in
        --lualatex) LATEX_ENGINE="lualatex" ;;
        -h|--help)  show_help; exit 0 ;;
        *) echo "Unbekannte Option: $arg"; show_help; exit 1 ;;
    esac
done

IMAGE_NAME="latex-seminar:latest"

echo "=== Docker PDF-Generierung ==="
echo "LaTeX-Engine: ${LATEX_ENGINE}"
echo ""

echo "[1/2] Baue Docker-Image..."
docker build -t "${IMAGE_NAME}" "${REPO_ROOT}"

echo ""
echo "[2/2] Erzeuge PDFs im Container..."
docker run --rm \
    -e LATEX_ENGINE="${LATEX_ENGINE}" \
    -v "${REPO_ROOT}/Ausarbeitung:/app/Ausarbeitung" \
    -v "${REPO_ROOT}/Vortrag:/app/Vortrag" \
    "${IMAGE_NAME}"

echo ""
echo "=== Fertig! PDFs wurden erzeugt. ==="
