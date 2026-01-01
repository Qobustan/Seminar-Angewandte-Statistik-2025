#!/usr/bin/perl
# ==============================================================================
#
#          FILE: lacheck.pl
#
#   DESCRIPTION: Checks a LaTeX document for errors
#
#       USAGE: lacheck.pl <tex_file>
#              lacheck.pl --help
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
    Checks a LaTeX document for common errors and warnings.
    Reports issues such as mismatched braces, bad spacing, and more.

Arguments:
    tex_file    Input LaTeX file (required)

Example:
    $0 document.tex
    $0 Hauptdatei.tex

EOF
    exit 0;
}

# Check if lacheck command is available
sub check_command {
    my $cmd = shift;
    system("which $cmd > /dev/null 2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("lacheck");

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file>\nRun '$0 --help' for more information.\n";

# Validate input file
die "Error: File '$tex_file' not found\n" unless -f $tex_file;
die "Error: File '$tex_file' is not readable\n" unless -r $tex_file;

# Check LaTeX document for errors
print "Checking LaTeX document '$tex_file' for errors...\n";
print "=" x 50 . "\n";
my $exit_code = system("lacheck", $tex_file);

if ($exit_code == 0) {
    print "=" x 50 . "\n";
    print "LaTeX document checked successfully.\n";
} else {
    # lacheck returns warnings as non-zero, which is expected
    print "=" x 50 . "\n";
    print "LaTeX document checked (warnings may be present).\n";
}
