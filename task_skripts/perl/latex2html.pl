#!/usr/bin/perl
# ==============================================================================
#
#          FILE: latex2html.pl
#
#   DESCRIPTION: Converts LaTeX to HTML
#
#       USAGE: latex2html.pl <tex_file>
#
#       OPTIONS: tex_file - Input LaTeX file (required)
#
# ==============================================================================

use strict;
use warnings;

# Check if latex2html command is available
sub check_command {
    my $cmd = shift;
    system("which $cmd > /dev/null 2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("latex2html");

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file>\n";

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
