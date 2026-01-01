#!/usr/bin/perl
# makeglossaries - Ein Perl-Skript zum Erstellen von Glossaren und Abkürzungsverzeichnissen

use strict;
use warnings;

my $tool = "makeglossaries";
my $check = `which $tool 2>/dev/null`;
die "Error: $tool is not installed. Please install it first.\n" unless $check;

my $document = $ARGV[0] // die "Usage: $0 <document>\n";

system("$tool $document") == 0
    or die "Error creating glossaries: $!\n";

print "Glossary for $document created successfully.\n";
