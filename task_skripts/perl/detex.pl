#!/usr/bin/perl
# ==============================================================================
#
#          FILE: detex.pl
#
#   DESCRIPTION: Removes LaTeX commands and extracts plain text
#
#       USAGE: detex.pl <tex_file> [output_file]
#
#       OPTIONS: tex_file    - Input LaTeX file (required)
#                output_file - Output text file (default: input_file.txt)
#
# ==============================================================================

use strict;
use warnings;
use File::Basename;

# Check if detex command is available
sub check_command {
    my $cmd = shift;
    system("which $cmd > /dev/null 2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("detex");

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file> [output_file]\n";
my $output_file = $ARGV[1] // $tex_file . ".txt";

# Validate input file
die "Error: File '$tex_file' not found\n" unless -f $tex_file;
die "Error: File '$tex_file' is not readable\n" unless -r $tex_file;

# Extract plain text using detex
print "Extracting plain text from '$tex_file' to '$output_file'...\n";
my $exit_code = system("detex $tex_file > $output_file");

if ($exit_code == 0) {
    print "Plain text extracted successfully to $output_file\n";
} else {
    die "Error: detex failed with exit code $exit_code\n";
}
