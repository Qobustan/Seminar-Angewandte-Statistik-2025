#!/usr/bin/perl
# ==============================================================================
#
#          FILE: latexpand.pl
#
#   DESCRIPTION: Expands LaTeX macros
#
#       USAGE: latexpand.pl <tex_file> [output_file]
#              latexpand.pl --help
#
#       OPTIONS: tex_file    - Input LaTeX file (required)
#                output_file - Output file (default: input_file.expanded)
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
    Expands LaTeX macros and includes into a single file.
    Useful for submission to journals or for creating standalone documents.

Arguments:
    tex_file       Input LaTeX file (required)
    output_file    Output file (default: input_file.expanded)

Examples:
    $0 document.tex
    $0 document.tex expanded_document.tex

EOF
    exit 0;
}

# Check if latexpand command is available
sub check_command {
    my $cmd = shift;
    my $output = `command -v $cmd 2>/dev/null`;
    return $output ne '';
}

unless (check_command("latexpand")) {
    die "Error: latexpand is not installed or not in PATH\n";
}

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file> [output_file]\nRun '$0 --help' for more information.\n";
my $output_file = $ARGV[1] // $tex_file . ".expanded";

# Validate input file
die "Error: File '$tex_file' not found\n" unless -f $tex_file;
die "Error: File '$tex_file' is not readable\n" unless -r $tex_file;

# Expand LaTeX macros
print "Expanding LaTeX macros in '$tex_file' to '$output_file'...\n";

# Open output file safely
open(my $out_fh, '>', $output_file) or die "Error: Cannot open output file '$output_file': $!\n";

# Use safe system call with list form
open(my $latexpand_fh, '-|', 'latexpand', $tex_file) or die "Error: Cannot run latexpand: $!\n";
print $out_fh $_ while <$latexpand_fh>;
close($latexpand_fh);
close($out_fh);

my $exit_code = $? >> 8;

if ($exit_code == 0) {
    my $size = -s $output_file;
    print "LaTeX document expanded and saved to $output_file\n";
    print "Output file size: $size bytes\n";
} else {
    die "Error: latexpand failed with exit code $exit_code\n";
}
