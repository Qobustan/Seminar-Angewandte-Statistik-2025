#!/bin/bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
#
# Erzeugt die PDFs mit LuaLaTeX.
# Delegiert an scripts/generatePdf-lualatex.sh.
#
# Verwendung:
#   ./bin/lualatex.sh

exec "$(dirname "$0")/../scripts/generatePdf-lualatex.sh" "$@"
