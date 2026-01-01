#!/usr/bin/perl
# latex2html - Ein Perl-Skript zum Konvertieren von LaTeX in HTML

use strict;
use warnings;

my $tool = "latex2html";
my $check = `which $tool 2>/dev/null`;
die "Error: $tool is not installed. Please install it first.\n" unless $check;

my $tex_file = $ARGV[0] // die "Usage: $0 <tex_file>\n";

system("$tool $tex_file") == 0
    or die "Error running $tool: $!\n";

print "LaTeX document converted to HTML successfully.\n";
