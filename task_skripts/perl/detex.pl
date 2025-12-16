#!/usr/bin/perl
# detex - Ein Perl-Skript zum Entfernen von LaTeX-Befehlen und Extrahieren von reinem Text

# Beispielaufruf:
# detex mein_dokument.tex > mein_dokument.txt

use strict;
use warnings;

my $tex_file = $ARGV[0] // die "Bitte LaTeX-Datei angeben";
my $output_file = $ARGV[1] // $tex_file . ".txt";

# Einfaches Kommando, um detex auszuführen
system("detex $tex_file > $output_file") == 0
    or die "Fehler beim Ausführen von detex: $!\n";

print "Reiner Text aus LaTeX-Dokument in $output_file extrahiert.\n";
