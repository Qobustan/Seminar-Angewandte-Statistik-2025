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
    system("command", "-v", $cmd, ">", "/dev/null", "2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("latexpand");

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file> [output_file]\nRun '$0 --help' for more information.\n";
my $output_file = $ARGV[1] // $tex_file . ".expanded";

# Validate input file
die "Error: File '$tex_file' not found\n" unless -f $tex_file;
die "Error: File '$tex_file' is not readable\n" unless -r $tex_file;

# Expand LaTeX macros
print "Expanding LaTeX macros in '$tex_file' to '$output_file'...\n";
my $exit_code = system("latexpand $tex_file > $output_file");

if ($exit_code == 0) {
    my $size = -s $output_file;
    print "LaTeX document expanded and saved to $output_file\n";
    print "Output file size: $size bytes\n";
} else {
    die "Error: latexpand failed with exit code $exit_code\n";
}
