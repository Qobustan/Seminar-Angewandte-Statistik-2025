#!/usr/bin/perl
# FILE: lacheck.pl
# DESCRIPTION: Ein Perl-Skript zum Überprüfen eines LaTeX-Dokuments auf Fehler
# USAGE: lacheck.pl <tex_file>
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
  Überprüft ein LaTeX-Dokument auf Fehler unter Verwendung von lacheck.

ARGUMENTS:
  <tex_file>     Die LaTeX-Datei zum Überprüfen (.tex)

OPTIONS:
  -h, --help     Zeige diese Hilfe an und beende das Programm

EXAMPLES:
  $script_name document.tex
  $script_name chapter1.tex

HELP
    exit 0;
}

# Prüfe auf --help Option
if (@ARGV && ($ARGV[0] eq '-h' || $ARGV[0] eq '--help')) {
    show_help();
}

# Tool-Verfügbarkeit prüfen (POSIX-kompatibel)
my $tool = "lacheck";
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

print "LaTeX document checked for errors.\n";
