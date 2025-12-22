#!/usr/bin/perl
# latexpand - Ein Perl-Skript zum Expandieren von LaTeX-Makros

use strict;
use warnings;

my $tool = "latexpand";
my $check = `which $tool 2>/dev/null`;
die "Error: $tool is not installed. Please install it first.\n" unless $check;

my $tex_file = $ARGV[0] // die "Usage: $0 <tex_file> [output_file]\n";
my $output_file = $ARGV[1] // $tex_file . ".expanded";

system("$tool $tex_file > $output_file") == 0
    or die "Error expanding LaTeX macros: $!\n";

print "LaTeX document expanded and saved to $output_file.\n";
