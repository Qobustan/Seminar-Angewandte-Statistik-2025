#!/usr/bin/perl
# ==============================================================================
#
#          FILE: latex2html.pl
#
#   DESCRIPTION: Converts LaTeX to HTML
#
#       USAGE: latex2html.pl <tex_file>
#              latex2html.pl --help
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
    Converts a LaTeX document to HTML format.
    Creates a directory with the converted HTML files and images.

Arguments:
    tex_file    Input LaTeX file (required)

Example:
    $0 document.tex
    $0 Hauptdatei.tex

EOF
    exit 0;
}

# Check if latex2html command is available
sub check_command {
    my $cmd = shift;
    system("which $cmd > /dev/null 2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("latex2html");

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file>\nRun '$0 --help' for more information.\n";

# Validate input file
die "Error: File '$tex_file' not found\n" unless -f $tex_file;
die "Error: File '$tex_file' is not readable\n" unless -r $tex_file;

# Convert LaTeX to HTML
print "Converting LaTeX document '$tex_file' to HTML...\n";
my $exit_code = system("latex2html", $tex_file);

if ($exit_code == 0) {
    print "LaTeX document successfully converted to HTML.\n";
} else {
    die "Error: latex2html failed with exit code $exit_code\n";
}
