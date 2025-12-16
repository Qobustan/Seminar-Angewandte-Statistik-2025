#!/usr/bin/perl
# latex2html - Ein Perl-Skript zum Konvertieren von LaTeX in HTML

# Beispielaufruf:
# latex2html mein_dokument.tex

use strict;
use warnings;

my $tex_file = $ARGV[0] // die "Bitte LaTeX-Datei angeben";

# Einfaches Kommando, um latex2html auszuführen
system("latex2html $tex_file") == 0
    or die "Fehler beim Ausführen von latex2html: $!\n";

print "LaTeX-Dokument erfolgreich in HTML konvertiert.\n";
