#!/usr/bin/perl
# bibtex2html - Ein Perl-Skript zum Konvertieren von BibTeX-Daten in HTML

# Beispielaufruf:
# bibtex2html -o mein_bibliographie mein_dokument.bib

use strict;
use warnings;

# Verweise auf die Bibliographie-Datei und Ausgabe-Verzeichnis
my $bib_file = $ARGV[0];
my $output_dir = $ARGV[1] // '.';

# Einfaches Kommando, um BibTeX-Daten in HTML umzuwandeln
system("bibtex2html -o $output_dir $bib_file") == 0
    or die "Fehler beim Ausführen von bibtex2html: $!\n";

print "Bibliographie in HTML erfolgreich erstellt.\n";
