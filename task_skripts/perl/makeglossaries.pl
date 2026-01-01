#!/usr/bin/perl
# ==============================================================================
#
#          FILE: makeglossaries.pl
#
#   DESCRIPTION: Creates glossaries and abbreviation lists
#
#       USAGE: makeglossaries.pl <document>
#
#       OPTIONS: document - LaTeX document base name (without .tex)
#
# ==============================================================================

use strict;
use warnings;

# Check if makeglossaries command is available
sub check_command {
    my $cmd = shift;
    system("which $cmd > /dev/null 2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("makeglossaries");

# Parse command line arguments
my $document = $ARGV[0] or die "Usage: $0 <document>\n";

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
