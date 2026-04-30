#!/bin/bash

# Code to generate PDF

# ... (previous lines)

# Line 91 update
if ! biber Ausarbeitung > /dev/null; then
    echo "Error: biber Ausarbeitung failed!"
    exit 1
fi

# ... (lines in between)

# Line 112 update
if ! biber Vortrag > /dev/null; then
    echo "Error: biber Vortrag failed!"
    exit 1
fi

# ... (followed by any remaining lines)