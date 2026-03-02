#!/bin/bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
#
# Convenience wrapper: generate PDFs using LuaLaTeX.
# Calls the main generatePdf.sh with LATEX_ENGINE=lualatex so that
# the existing PDFLaTeX script is left completely unchanged.
#
# Usage:
#   ./scripts/generatePdf-lualatex.sh
#
# Equivalent to:
#   LATEX_ENGINE=lualatex ./scripts/generatePdf.sh

LATEX_ENGINE=lualatex exec "$(dirname "$0")/generatePdf.sh" "$@"
