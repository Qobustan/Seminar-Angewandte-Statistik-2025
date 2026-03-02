# Latexmk-Konfiguration für Ausarbeitung
# Stellt sicher, dass biber anstelle von bibtex verwendet wird (kompatibel mit biblatex + backend=biber)
$pdf_mode    = 1;   # pdflatex
$bibtex_use  = 2;   # 0 = nie, 1 = nur wenn .bib neuer als .bbl, 2 = biber/bibtex immer ausführen
