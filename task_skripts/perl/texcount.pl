#!/usr/bin/perl
# ==============================================================================
#
#          FILE: texcount.pl
#
#   DESCRIPTION: Counts words in a LaTeX document
#
#       USAGE: texcount.pl <tex_file>
#              texcount.pl --help
#
#       OPTIONS: tex_file - Input LaTeX file (required)
#                --help   - Show this help message
#
# ==============================================================================

use strict;
use warnings;

# Show help if requested
if (@ARGV && ($ARGV[0] eq '-h' || $ARGV[0] eq '--help')) {
    print << "EOF";
Usage: $0 <tex_file>

Description:
    Counts words, headers, and other elements in a LaTeX document.
    Provides detailed statistics about the document structure.

Arguments:
    tex_file    Input LaTeX file (required)

Example:
    $0 document.tex
    $0 Hauptdatei.tex

EOF
    exit 0;
}

# Check if texcount command is available
sub check_command {
    my $cmd = shift;
    system("which $cmd > /dev/null 2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("texcount");

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file>\nRun '$0 --help' for more information.\n";

# Validate input file
die "Error: File '$tex_file' not found\n" unless -f $tex_file;
die "Error: File '$tex_file' is not readable\n" unless -r $tex_file;

# Count words in LaTeX document
print "Counting words in '$tex_file'...\n";
print "=" x 50 . "\n";
my $exit_code = system("texcount", $tex_file);

if ($exit_code == 0) {
    print "=" x 50 . "\n";
    print "Word count completed.\n";
} else {
    die "Error: texcount failed with exit code $exit_code\n";
}
