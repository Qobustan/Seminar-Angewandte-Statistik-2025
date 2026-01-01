#!/usr/bin/perl
# FILE: bibtex2html.pl
# DESCRIPTION: Ein Perl-Skript zum Konvertieren von BibTeX-Daten in HTML
# USAGE: bibtex2html.pl <bibfile> [output_dir]
# OPTIONS:
#   -h, --help    Zeige diese Hilfe an

use strict;
use warnings;
use File::Basename;

# Hilfe-Funktion
sub show_help {
    my $script_name = basename($0);
    print <<"HELP";
USAGE: $script_name <bibfile> [output_dir]

DESCRIPTION:
  Konvertiert BibTeX-Daten in HTML-Format unter Verwendung von bibtex2html.

ARGUMENTS:
  <bibfile>      Die BibTeX-Eingabedatei (.bib)
  [output_dir]   Das Ausgabeverzeichnis (optional, Standard: aktuelles Verzeichnis)

OPTIONS:
  -h, --help     Zeige diese Hilfe an und beende das Programm

EXAMPLES:
  $script_name references.bib
  $script_name references.bib output/

HELP
    exit 0;
}

# Prüfe auf --help Option
if (@ARGV && ($ARGV[0] eq '-h' || $ARGV[0] eq '--help')) {
    show_help();
}

# Tool-Verfügbarkeit prüfen (POSIX-kompatibel)
my $tool = "bibtex2html";
my $tool_path = `command -v $tool 2>/dev/null`;
chomp($tool_path);
die "Error: $tool is not installed. Please install it first.\n" unless $tool_path;

# Argumente validieren
my $bib_file = $ARGV[0] // die "Error: No input file specified.\nUse --help for usage information.\n";
my $output_dir = $ARGV[1] // '.';

# Eingabedatei validieren
die "Error: File '$bib_file' does not exist.\n" unless -e $bib_file;
die "Error: File '$bib_file' is not readable.\n" unless -r $bib_file;
die "Error: File '$bib_file' is not a regular file.\n" unless -f $bib_file;

# Output-Verzeichnis prüfen/erstellen
unless (-d $output_dir) {
    mkdir($output_dir) or die "Error: Cannot create output directory '$output_dir': $!\n";
}

# Tool ausführen
system("$tool", "-o", $output_dir, $bib_file) == 0
    or die "Error running $tool: $!\n";

print "Bibliography converted to HTML successfully.\n";
