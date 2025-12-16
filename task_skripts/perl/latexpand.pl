#!/usr/bin/perl
# latexpand - Ein Perl-Skript zum Expandieren von LaTeX-Makros

# Beispielaufruf:
# latexpand mein_dokument.tex > expandiertes_dokument.tex

use strict;
use warnings;

my $tex_file = $ARGV[0] // die "Bitte LaTeX-Datei angeben";
my $output_file = $ARGV[1] // $tex_file . ".expanded";

# Einfaches Kommando, um latexpand auszuführen
system("latexpand $tex_file > $output_file") == 0
    or die "Fehler beim Expandieren von LaTeX-Makros: $!\n";

print "LaTeX-Dokument expandiert und in $output_file gespeichert.\n";
