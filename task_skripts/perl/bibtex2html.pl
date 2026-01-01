#!/usr/bin/perl
# bibtex2html - Ein Perl-Skript zum Konvertieren von BibTeX-Daten in HTML

use strict;
use warnings;

my $tool = "bibtex2html";
my $check = `which $tool 2>/dev/null`;
die "Error: $tool is not installed. Please install it first.\n" unless $check;

my $bib_file = $ARGV[0] // die "Usage: $0 <bibfile> [output_dir]\n";
my $output_dir = $ARGV[1] // '.';

system("$tool -o $output_dir $bib_file") == 0
    or die "Error running $tool: $!\n";

print "Bibliography converted to HTML successfully.\n";
