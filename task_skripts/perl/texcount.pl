#!/usr/bin/perl
# texcount - Ein Perl-Skript zum Zählen der Wörter in einem LaTeX-Dokument

# Beispielaufruf:
# texcount mein_dokument.tex

use strict;
use warnings;

my $tex_file = $ARGV[0] // die "Bitte LaTeX-Datei angeben";

# Einfaches Kommando, um Texcount auszuführen
system("texcount $tex_file") == 0
    or die "Fehler beim Ausführen von texcount: $!\n";

print "Wortzählung abgeschlossen.\n";
