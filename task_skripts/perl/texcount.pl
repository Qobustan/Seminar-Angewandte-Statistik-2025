#!/usr/bin/perl
# ==============================================================================
#
#          FILE: texcount.pl
#
#   DESCRIPTION: Counts words in a LaTeX document
#
#       USAGE: texcount.pl <tex_file>
#
#       OPTIONS: tex_file - Input LaTeX file (required)
#
# ==============================================================================

use strict;
use warnings;

# Check if texcount command is available
sub check_command {
    my $cmd = shift;
    system("which $cmd > /dev/null 2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("texcount");

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file>\n";

# Validate input file
die "Error: File '$tex_file' not found\n" unless -f $tex_file;
die "Error: File '$tex_file' is not readable\n" unless -r $tex_file;

# Count words in LaTeX document
print "Counting words in '$tex_file'...\n";
my $exit_code = system("texcount", $tex_file);

if ($exit_code == 0) {
    print "Word count completed.\n";
} else {
    die "Error: texcount failed with exit code $exit_code\n";
}
