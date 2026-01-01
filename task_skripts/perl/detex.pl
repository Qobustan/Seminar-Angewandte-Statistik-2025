#!/usr/bin/perl
# detex - Ein Perl-Skript zum Entfernen von LaTeX-Befehlen und Extrahieren von reinem Text

use strict;
use warnings;

my $tool = "detex";
my $check = `which $tool 2>/dev/null`;
die "Error: $tool is not installed. Please install it first.\n" unless $check;

my $tex_file = $ARGV[0] // die "Usage: $0 <tex_file> [output_file]\n";
my $output_file = $ARGV[1] // $tex_file . ".txt";

system("$tool $tex_file > $output_file") == 0
    or die "Error running $tool: $!\n";

print "Plain text extracted to $output_file.\n";
