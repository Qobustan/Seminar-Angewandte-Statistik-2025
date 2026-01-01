#!/usr/bin/perl
# ==============================================================================
#
#          FILE: lacheck.pl
#
#   DESCRIPTION: Checks a LaTeX document for errors
#
#       USAGE: lacheck.pl <tex_file>
#
#       OPTIONS: tex_file - Input LaTeX file (required)
#
# ==============================================================================

use strict;
use warnings;

# Check if lacheck command is available
sub check_command {
    my $cmd = shift;
    system("which $cmd > /dev/null 2>&1") == 0
        or die "Error: $cmd is not installed or not in PATH\n";
}

check_command("lacheck");

# Parse command line arguments
my $tex_file = $ARGV[0] or die "Usage: $0 <tex_file>\n";

# Validate input file
die "Error: File '$tex_file' not found\n" unless -f $tex_file;
die "Error: File '$tex_file' is not readable\n" unless -r $tex_file;

# Check LaTeX document for errors
print "Checking LaTeX document '$tex_file' for errors...\n";
my $exit_code = system("lacheck", $tex_file);

if ($exit_code == 0) {
    print "LaTeX document checked successfully.\n";
} else {
    # lacheck returns warnings as non-zero, which is expected
    print "LaTeX document checked (warnings may be present).\n";
}
