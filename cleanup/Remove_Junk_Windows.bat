@echo off
REM ==============================================================================
REM
REM          FILE: Remove_Junk_Windows.bat
REM
REM   DESCRIPTION: Removes temporary LaTeX build files (Windows)
REM
REM       OPTIONS: SHOW_COMMENTS - set to true to show comment output
REM
REM ==============================================================================

setlocal enabledelayedexpansion

set "SHOW_COMMENTS=true"

REM Function to check if directory exists and handle errors
if "%SHOW_COMMENTS%"=="true" echo REM Removing temporary LaTeX files in current directory

REM Define file patterns to remove
set "PATTERNS=*.aux *.log *.lof *.gz *.toc *.bak~ *.bbl *.bcf *.blg *.lot *.out *.xml *.acn *.acr *.alg *.glg *.glo *.gls *.gug *.guo *.gus *.ist *.llg *.llo *.lls *.lug *.luo *.lus *.mog *.moo *.mos *.xdy *.mw *.synctex.gz *.fdb_latexmk *.fls *.idx *.ind *.ilg *.dvi *.ps"

REM Remove files in current directory (suppress errors for non-existent files)
for %%P in (%PATTERNS%) do (
    if exist %%P (
        del /Q %%P 2>nul
    )
)

REM Wechsel in das Verzeichnis 'Ausarbeitung'
if "%SHOW_COMMENTS%"=="true" echo REM Changing to directory 'Ausarbeitung'

if exist "Ausarbeitung\" (
    pushd Ausarbeitung
    
    REM Löschen der gleichen temporären Dateien im Zielverzeichnis
    if "%SHOW_COMMENTS%"=="true" echo REM Removing temporary LaTeX files in Ausarbeitung directory
    
    for %%P in (%PATTERNS%) do (
        if exist %%P (
            del /Q %%P 2>nul
        )
    )
    
    popd
) else (
    if "%SHOW_COMMENTS%"=="true" echo REM Warning: Directory 'Ausarbeitung' not found, skipping
)

endlocal
