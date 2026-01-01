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
#       OPTIONS: -h, --help    Show this help message
#
# ==============================================================================

set -euo pipefail

# Show help if requested
if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    cat << EOF
Usage: $0

Description:
    Builds the web application in a local 'debug' directory.
    This is useful for testing the build process locally before deployment.

Example:
    $0

EOF
    exit 0
fi

TARGET_DIR=debug

# Remove existing debug directory if it exists
if [[ -d "$TARGET_DIR" ]]; then
    echo "Removing existing debug directory..."
    rm -rf "$TARGET_DIR"
fi

# Create new debug directory
mkdir -p "$TARGET_DIR"

echo "Building in debug mode..."
# Run build script
./build.sh "$TARGET_DIR" gituser/example-repo latex.example.net

echo "Build complete! Output in ./$TARGET_DIR/"
