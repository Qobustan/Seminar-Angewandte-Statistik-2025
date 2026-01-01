#!/bin/bash

# Kontrollvariable für die Ausgabe von Kommentaren
SHOW_COMMENTS=true

# Die Dateipfade müsste man anpassen, wenn man das braucht
if [ "$SHOW_COMMENTS" = true ]; then
    echo "# Die Dateipfade müsste man anpassen, wenn man das braucht"
fi
rm -r -f *.aux *.log *.lof *.gz *.toc *.bak~ *.bbl *.bcf *.blg *.lot *.out *.xml *.acn *.acr *.alg *.glg *.glo *.gls *.gug *.guo *.gus *.ist *.llg *.llo *.lls *.lug *.luo *.lus *.mog *.moo *.mos *.xdy *.mw

# Wechsel in das Verzeichnis 'Ausarbeitung'
if [ "$SHOW_COMMENTS" = true ]; then
    echo "# Wechsel in das Verzeichnis 'Ausarbeitung'"
fi
cd Ausarbeitung

# Löschen der gleichen temporären Dateien im Zielverzeichnis
if [ "$SHOW_COMMENTS" = true ]; then
    echo "# Löschen der gleichen temporären Dateien im Zielverzeichnis"
fi
rm -r -f *.aux *.log *.lof *.gz *.toc *.bak~ *.bbl *.bcf *.blg *.lot *.out *.xml *.acn *.acr *.alg *.glg *.glo *.gls *.gug *.guo *.gus *.ist *.llg *.llo *.lls *.lug *.luo *.lus *.mog *.moo *.mos *.xdy *.mw
