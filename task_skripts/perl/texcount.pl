#!/usr/bin/perl
# texcount - Ein Perl-Skript zum Zählen der Wörter in einem LaTeX-Dokument

use strict;
use warnings;

my $tool = "texcount";
my $check = `which $tool 2>/dev/null`;
die "Error: $tool is not installed. Please install it first.\n" unless $check;

my $tex_file = $ARGV[0] // die "Usage: $0 <tex_file>\n";

system("$tool $tex_file") == 0
    or die "Error running $tool: $!\n";

print "Word count completed.\n";
