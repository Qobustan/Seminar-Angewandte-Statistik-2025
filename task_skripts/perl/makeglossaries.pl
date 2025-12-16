#!/usr/bin/perl
# makeglossaries - Ein Perl-Skript zum Erstellen von Glossaren und Abkürzungsverzeichnissen

# Beispielaufruf:
# makeglossaries mein_dokument

use strict;
use warnings;

my $document = $ARGV[0] // die "Bitte LaTeX-Dokument angeben";

# Einfaches Kommando, um makeglossaries auszuführen
system("makeglossaries $document") == 0
    or die "Fehler beim Erstellen von Glossaren: $!\n";

print "Glossar für $document erfolgreich erstellt.\n";
