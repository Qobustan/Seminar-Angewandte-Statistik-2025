#!/bin/bash
# ==============================================================================
#
#          FILE: debug.sh
#
#         USAGE: ./debug.sh
#
#   DESCRIPTION: This script builds the web application in a local directory
#                named 'debug'.
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Yavuzâlp Dal
#  ORGANIZATION: ---
#       CREATED: ---
#      REVISION: ---
#
# ==============================================================================

set -euo pipefail

TARGET_DIR=debug

# Remove existing debug directory if it exists
if [[ -d "$TARGET_DIR" ]]; then
    rm -rf "$TARGET_DIR"
fi

# Create new debug directory
mkdir -p "$TARGET_DIR"

# Run build script
./build.sh "$TARGET_DIR" gituser/example-repo latex.example.net
