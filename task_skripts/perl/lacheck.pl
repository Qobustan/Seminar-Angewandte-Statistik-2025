#!/usr/bin/perl
# lacheck - Ein Perl-Skript zum Überprüfen eines LaTeX-Dokuments auf Fehler

# Beispielaufruf:
# lacheck mein_dokument.tex

use strict;
use warnings;

my $tex_file = $ARGV[0] // die "Bitte LaTeX-Datei angeben";

# Einfaches Kommando, um lacheck auszuführen
system("lacheck $tex_file") == 0
    or die "Fehler beim Ausführen von lacheck: $!\n";

print "LaTeX-Dokument auf Fehler überprüft.\n";
