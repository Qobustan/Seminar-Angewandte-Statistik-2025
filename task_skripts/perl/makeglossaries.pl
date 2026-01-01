#!/usr/bin/perl
# FILE: makeglossaries.pl
# DESCRIPTION: Ein Perl-Skript zum Erstellen von Glossaren und Abkürzungsverzeichnissen
# USAGE: makeglossaries.pl <document>
# OPTIONS:
#   -h, --help    Zeige diese Hilfe an

use strict;
use warnings;
use File::Basename;

# Hilfe-Funktion
sub show_help {
    my $script_name = basename($0);
    print <<"HELP";
USAGE: $script_name <document>

DESCRIPTION:
  Erstellt Glossare und Abkürzungsverzeichnisse für ein LaTeX-Dokument
  unter Verwendung von makeglossaries. Das Tool benötigt die .aux-Datei,
  die von einem vorherigen LaTeX-Lauf generiert wurde.

ARGUMENTS:
  <document>     Der Dokumentname (mit oder ohne .tex-Endung)

OPTIONS:
  -h, --help     Zeige diese Hilfe an und beende das Programm

EXAMPLES:
  $script_name document
  $script_name document.tex

NOTES:
  - Die .aux-Datei muss existieren (führen Sie pdflatex/latex zuerst aus)
  - Die .tex-Endung wird automatisch entfernt, falls vorhanden

HELP
    exit 0;
}

# Prüfe auf --help Option
if (@ARGV && ($ARGV[0] eq '-h' || $ARGV[0] eq '--help')) {
    show_help();
}

# Tool-Verfügbarkeit prüfen (POSIX-kompatibel)
my $tool = "makeglossaries";
my $tool_path = `command -v $tool 2>/dev/null`;
chomp($tool_path);
die "Error: $tool is not installed. Please install it first.\n" unless $tool_path;

# Argumente validieren
my $document = $ARGV[0] // die "Error: No document name specified.\nUse --help for usage information.\n";

# Entferne .tex-Endung falls vorhanden
$document =~ s/\.tex$//;

# Prüfe ob .aux-Datei existiert (Voraussetzung für makeglossaries)
my $aux_file = "$document.aux";
die "Error: File '$aux_file' does not exist.\nPlease run pdflatex/latex first to generate the .aux file.\n" unless -e $aux_file;
die "Error: File '$aux_file' is not a regular file.\n" unless -f $aux_file;
die "Error: File '$aux_file' is not readable.\n" unless -r $aux_file;

# Tool ausführen
system("$tool", $document) == 0
    or die "Error creating glossaries: $!\n";

print "Glossary for $document created successfully.\n";
