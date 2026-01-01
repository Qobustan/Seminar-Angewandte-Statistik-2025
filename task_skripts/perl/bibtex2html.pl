#!/usr/bin/perl
# ==============================================================================
#
#          FILE: bibtex2html.pl
#
#   DESCRIPTION: Converts BibTeX data to HTML format
#
#       USAGE: bibtex2html.pl <bib_file> [output_dir]
#
#       OPTIONS: bib_file    - Input BibTeX file (required)
#                output_dir  - Output directory (default: current directory)
#
# ==============================================================================

use strict;
use warnings;
use File::Basename;
use Cwd 'abs_path';

# Check if bibtex2html command is available
sub check_command {
    my $cmd = shift;
    system("which $cmd > /dev/null 2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("bibtex2html");

# Parse command line arguments
my $bib_file = $ARGV[0];
my $output_dir = $ARGV[1] // '.';

# Validate input file
die "Usage: $0 <bib_file> [output_dir]\n" unless defined $bib_file;
die "Error: File '$bib_file' not found\n" unless -f $bib_file;
die "Error: File '$bib_file' is not readable\n" unless -r $bib_file;

# Validate or create output directory
if (! -d $output_dir) {
    mkdir $output_dir or die "Error: Cannot create directory '$output_dir': $!\n";
}
die "Error: Directory '$output_dir' is not writable\n" unless -w $output_dir;

# Convert BibTeX to HTML
print "Converting '$bib_file' to HTML in '$output_dir'...\n";
my $exit_code = system("bibtex2html", "-o", $output_dir, $bib_file);

if ($exit_code == 0) {
    print "Bibliography in HTML successfully created.\n";
} else {
    die "Error: bibtex2html failed with exit code $exit_code\n";
}
