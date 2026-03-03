#!/bin/bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
#
# Erzeugt die PDFs mit pdflatex.
# Delegiert an scripts/generatePdf.sh.
#
# Verwendung:
#   ./bin/pdf.sh

exec "$(dirname "$0")/../scripts/generatePdf.sh" "$@"
