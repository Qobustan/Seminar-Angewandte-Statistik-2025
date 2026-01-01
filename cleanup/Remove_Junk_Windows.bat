@echo off
set SHOW_COMMENTS=true

REM Die Dateipfade müsste man anpassen, wenn man das braucht
if "%SHOW_COMMENTS%"=="true" echo REM Die Dateipfade müsste man anpassen, wenn man das braucht
del *.aux *.log *.lof *.gz *.toc *.bak~ *.bbl *.bcf *.blg *.lot *.out *.xml *.acn *.acr *.alg *.glg *.glo *.gls *.gug *.guo *.gus *.ist *.llg *.llo *.lls *.lug *.luo *.lus *.mog *.moo *.mos *.xdy *.mw *.synctex.gz *.fdb_latexmk *.fls *.idx *.ind *.ilg *.glg *.glo *.gls *.dvi *.ps *.pdf

REM Wechsel in das Verzeichnis 'Ausarbeitung'
if "%SHOW_COMMENTS%"=="true" echo REM Wechsel in das Verzeichnis 'Ausarbeitung'
chdir Ausarbeitung

REM Löschen der gleichen temporären Dateien im Zielverzeichnis
if "%SHOW_COMMENTS%"=="true" echo REM Löschen der gleichen temporären Dateien im Zielverzeichnis
del *.aux *.log *.lof *.gz *.toc *.bak~ *.bbl *.bcf *.blg *.lot *.out *.xml *.acn *.acr *.alg *.glg *.glo *.gls *.gug *.guo *.gus *.ist *.llg *.llo *.lls *.lug *.luo *.lus *.mog *.moo *.mos *.xdy *.mw *.synctex.gz *.fdb_latexmk *.fls *.idx *.ind *.ilg *.glg *.glo *.gls *.dvi *.ps *.pdf
