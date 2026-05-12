#!/bin/bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 The Project Authors

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
LUA_BIN="$REPO_ROOT/lua-5.5.0/src/lua"

show_help() {
    cat << 'EOF'
Usage: ./scripts/manage.sh <command> [args...]

Unified entrypoint for common project tools.

Commands:
  build-pdf [args...]           Build PDFs (scripts/generatePdf.sh)
  build-pdf-lualatex [args...]  Build PDFs with LuaLaTeX (scripts/generatePdf-lualatex.sh)
  clean [args...]               Remove LaTeX build artifacts (cleanup/Remove_Junk_Linux.sh)
  build-lua                     Build bundled Lua interpreter (lua-5.5.0)
  word-count [files...]         Run scripts/word-count.lua (default main documents)
  check-bib [files...]          Run scripts/check-bib.lua (default Ausarbeitung/Ausarbeitung.bib)
  branch-cleanup [args...]      Run scripts/delete-obsolete-branches.sh
  branch-cleanup-py [args...]   Run scripts/delete-obsolete-branches.py
  help                          Show this help

Examples:
  ./scripts/manage.sh build-pdf
  ./scripts/manage.sh clean
  ./scripts/manage.sh build-lua
  ./scripts/manage.sh word-count Ausarbeitung/Ausarbeitung.tex
  ./scripts/manage.sh check-bib
EOF
}

require_lua() {
    if [[ ! -x "$LUA_BIN" ]]; then
        echo "Lua interpreter not found at $LUA_BIN"
        echo "Run: ./scripts/manage.sh build-lua"
        exit 1
    fi
}

command="${1:-help}"
if [[ $# -gt 0 ]]; then
    shift
fi

case "$command" in
    help|-h|--help)
        show_help
        ;;
    build-pdf)
        exec "$SCRIPT_DIR/generatePdf.sh" "$@"
        ;;
    build-pdf-lualatex)
        exec "$SCRIPT_DIR/generatePdf-lualatex.sh" "$@"
        ;;
    clean)
        exec "$REPO_ROOT/cleanup/Remove_Junk_Linux.sh" "$@"
        ;;
    build-lua)
        exec make -C "$REPO_ROOT/lua-5.5.0" linux -j"$(nproc)"
        ;;
    word-count)
        require_lua
        exec "$LUA_BIN" "$SCRIPT_DIR/word-count.lua" "$@"
        ;;
    check-bib)
        require_lua
        exec "$LUA_BIN" "$SCRIPT_DIR/check-bib.lua" "$@"
        ;;
    branch-cleanup)
        exec "$SCRIPT_DIR/delete-obsolete-branches.sh" "$@"
        ;;
    branch-cleanup-py)
        exec python3 "$SCRIPT_DIR/delete-obsolete-branches.py" "$@"
        ;;
    *)
        echo "Unknown command: $command" >&2
        echo "Run './scripts/manage.sh help' for available commands." >&2
        exit 2
        ;;
esac
