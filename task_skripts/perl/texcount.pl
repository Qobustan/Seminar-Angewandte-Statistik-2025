#!/usr/bin/perl
# FILE: texcount.pl
# DESCRIPTION: Ein Perl-Skript zum Zählen der Wörter in einem LaTeX-Dokument
# USAGE: texcount.pl <tex_file>
# OPTIONS:
#   -h, --help    Zeige diese Hilfe an

use strict;
use warnings;
use File::Basename;

# Hilfe-Funktion
sub show_help {
    my $script_name = basename($0);
    print <<"HELP";
USAGE: $script_name <tex_file>

DESCRIPTION:
  Zählt die Wörter in einem LaTeX-Dokument unter Verwendung von texcount.

ARGUMENTS:
  <tex_file>     Die LaTeX-Datei zum Analysieren (.tex)

OPTIONS:
  -h, --help     Zeige diese Hilfe an und beende das Programm

EXAMPLES:
  $script_name document.tex
  $script_name thesis.tex

HELP
    exit 0;
}

# Prüfe auf --help Option
if (@ARGV && ($ARGV[0] eq '-h' || $ARGV[0] eq '--help')) {
    show_help();
}

# Tool-Verfügbarkeit prüfen (POSIX-kompatibel)
my $tool = "texcount";
my $tool_path = `command -v $tool 2>/dev/null`;
chomp($tool_path);
die "Error: $tool is not installed. Please install it first.\n" unless $tool_path;

# Argumente validieren
my $tex_file = $ARGV[0] // die "Error: No input file specified.\nUse --help for usage information.\n";

# Eingabedatei validieren
die "Error: File '$tex_file' does not exist.\n" unless -e $tex_file;
die "Error: File '$tex_file' is not readable.\n" unless -r $tex_file;
die "Error: File '$tex_file' is not a regular file.\n" unless -f $tex_file;

# Tool ausführen
system("$tool", $tex_file) == 0
    or die "Error running $tool: $!\n";

print "Word count completed.\n";
