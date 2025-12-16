# Setze die LaTeX-Engine auf pdflatex
$latex = 'pdflatex -interaction=nonstopmode -file-line-error %O %S';

# Setze den BibTeX-Editor (falls verwendet)
$bibtex = 'bibtex %O %S';

# Verwende PDF-Ansicht als Standard
$pdf_mode = 1;

# Verhindere, dass latexmk automatisch .bbl-Dateien löscht
$cleanup_mode = 0;

# Führe die Kompilierung mehrmals aus, um alle Referenzen zu aktualisieren
$max_repeat = 5;
