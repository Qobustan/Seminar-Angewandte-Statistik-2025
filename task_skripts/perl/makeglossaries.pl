#!/usr/bin/perl
# ==============================================================================
#
#          FILE: makeglossaries.pl
#
#   DESCRIPTION: Creates glossaries and abbreviation lists
#
#       USAGE: makeglossaries.pl <document>
#              makeglossaries.pl --help
#
#       OPTIONS: document - LaTeX document base name (without .tex)
#                --help   - Show this help message
#
# ==============================================================================

use strict;
use warnings;

# Show help if requested
if (@ARGV && ($ARGV[0] eq '-h' || $ARGV[0] eq '--help')) {
    print << "EOF";
Usage: $0 <document>

Description:
    Creates glossaries and abbreviation lists for a LaTeX document.
    Processes glossary entries and generates the formatted output.

Arguments:
    document    LaTeX document base name (without .tex extension)

Requirements:
    - The document must have been compiled with pdflatex first
    - The .aux file must exist

Examples:
    $0 Hauptdatei
    $0 thesis

EOF
    exit 0;
}

# Check if makeglossaries command is available
sub check_command {
    my $cmd = shift;
    my $output = `command -v $cmd 2>/dev/null`;
    return $output ne '';
}

unless (check_command("makeglossaries")) {
    die "Error: makeglossaries is not installed or not in PATH\n";
}

# Parse command line arguments
my $document = $ARGV[0] or die "Usage: $0 <document>\nRun '$0 --help' for more information.\n";

# Remove .tex extension if provided
$document =~ s/\.tex$//;

# Check if auxiliary files exist
my $aux_file = "$document.aux";
die "Error: Auxiliary file '$aux_file' not found. Please run LaTeX first.\n" 
    unless -f $aux_file;

# Create glossaries
print "Creating glossaries for '$document'...\n";
my $exit_code = system("makeglossaries", $document);

if ($exit_code == 0) {
    print "Glossaries for $document successfully created.\n";
} else {
    die "Error: makeglossaries failed with exit code $exit_code\n";
}
