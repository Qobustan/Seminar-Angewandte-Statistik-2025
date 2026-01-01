#!/usr/bin/perl
# FILE: detex.pl
# DESCRIPTION: Ein Perl-Skript zum Entfernen von LaTeX-Befehlen und Extrahieren von reinem Text
# USAGE: detex.pl <tex_file> [output_file]
# OPTIONS:
#   -h, --help    Zeige diese Hilfe an

use strict;
use warnings;
use File::Basename;

# Hilfe-Funktion
sub show_help {
    my $script_name = basename($0);
    print <<"HELP";
USAGE: $script_name <tex_file> [output_file]

DESCRIPTION:
  Entfernt LaTeX-Befehle und extrahiert reinen Text aus einer .tex-Datei
  unter Verwendung von detex.

ARGUMENTS:
  <tex_file>      Die LaTeX-Eingabedatei (.tex)
  [output_file]   Die Ausgabedatei (optional, Standard: <tex_file>.txt)

OPTIONS:
  -h, --help      Zeige diese Hilfe an und beende das Programm

EXAMPLES:
  $script_name document.tex
  $script_name document.tex output.txt

HELP
    exit 0;
}

# Prüfe auf --help Option
if (@ARGV && ($ARGV[0] eq '-h' || $ARGV[0] eq '--help')) {
    show_help();
}

# Tool-Verfügbarkeit prüfen (POSIX-kompatibel)
my $tool = "detex";
my $tool_path = `command -v $tool 2>/dev/null`;
chomp($tool_path);
die "Error: $tool is not installed. Please install it first.\n" unless $tool_path;

# Argumente validieren
my $tex_file = $ARGV[0] // die "Error: No input file specified.\nUse --help for usage information.\n";
my $output_file = $ARGV[1] // $tex_file . ".txt";

# Eingabedatei validieren
die "Error: File '$tex_file' does not exist.\n" unless -e $tex_file;
die "Error: File '$tex_file' is not readable.\n" unless -r $tex_file;
die "Error: File '$tex_file' is not a regular file.\n" unless -f $tex_file;

# Tool sicher ausführen (ohne Shell-Interpolation)
open(my $tool_fh, '-|', $tool, $tex_file)
    or die "Error: Cannot run $tool: $!\n";

open(my $output_fh, '>', $output_file) 
    or die "Error: Cannot open output file '$output_file': $!\n";

# Ausgabe in Datei schreiben
while (my $line = <$tool_fh>) {
    print $output_fh $line;
}

# Prüfe Tool-Exit-Status und schließe Handles
my $tool_success = close($tool_fh);
my $file_success = close($output_fh);

die "Error running $tool: $!\n" unless $tool_success;
die "Error closing output file: $!\n" unless $file_success;

print "Plain text extracted to $output_file.\n";
