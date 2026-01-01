#!/usr/bin/perl
# ==============================================================================
#
#          FILE: detex.pl
#
#   DESCRIPTION: Removes LaTeX commands and extracts plain text
#
#       USAGE: detex.pl <tex_file> [output_file]
#              detex.pl --help
#
#       OPTIONS: tex_file    - Input LaTeX file (required)
#                output_file - Output text file (default: input_file.txt)
#                --help      - Show this help message
#
# ==============================================================================

use strict;
use warnings;

# Show help if requested
if (@ARGV && ($ARGV[0] eq '-h' || $ARGV[0] eq '--help')) {
    print << "EOF";
Usage: $0 <tex_file> [output_file]

Description:
    Removes LaTeX commands and extracts plain text from a LaTeX document.
    Useful for spell checking or word processing.

Arguments:
    tex_file       Input LaTeX file (required)
    output_file    Output text file (default: input_file.txt)

Examples:
    $0 document.tex
    $0 document.tex plain_text.txt

EOF
    exit 0;
}

# Check if detex command is available
sub check_command {
    my $cmd = shift;
    my $output = `command -v $cmd 2>/dev/null`;
    return $output ne '';
}

unless (check_command("detex")) {
    die "Error: detex is not installed or not in PATH\n";
}

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file> [output_file]\nRun '$0 --help' for more information.\n";
my $output_file = $ARGV[1] // $tex_file . ".txt";

# Validate input file
die "Error: File '$tex_file' not found\n" unless -f $tex_file;
die "Error: File '$tex_file' is not readable\n" unless -r $tex_file;

# Extract plain text using detex
print "Extracting plain text from '$tex_file' to '$output_file'...\n";

# Open output file safely
open(my $out_fh, '>', $output_file) or die "Error: Cannot open output file '$output_file': $!\n";

# Use safe system call with list form
open(my $detex_fh, '-|', 'detex', $tex_file) or die "Error: Cannot run detex: $!\n";
print $out_fh $_ while <$detex_fh>;
close($detex_fh);
close($out_fh);

my $exit_code = $? >> 8;

if ($exit_code == 0) {
    my $size = -s $output_file;
    print "Plain text extracted successfully to $output_file\n";
    print "Output file size: $size bytes\n";
} else {
    die "Error: detex failed with exit code $exit_code\n";
}
