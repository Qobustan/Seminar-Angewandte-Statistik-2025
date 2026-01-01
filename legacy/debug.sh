#!/bin/bash
# ==============================================================================
#
#          FILE: debug.sh
#
#         USAGE: ./debug.sh [OPTIONS]
#
#   DESCRIPTION: Debug script for building Seminar LaTeX documents with verbose
#                output. This is a convenience wrapper around build.sh.
#
#       OPTIONS: Same as build.sh (see build.sh --help)
#  REQUIREMENTS: pdflatex, bibtex (TeX Live or similar LaTeX distribution)
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Yavuzâlp Dal
#  ORGANIZATION: ---
#       CREATED: ---
#      REVISION: 2026-01-01 - Updated for Seminar repository
#
# ==============================================================================

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run build.sh with verbose mode enabled by default
"$SCRIPT_DIR/build.sh" --verbose "$@"
