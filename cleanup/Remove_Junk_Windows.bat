@echo off
REM ==============================================================================
REM
REM          FILE: Remove_Junk_Windows.bat
REM
REM         USAGE: Remove_Junk_Windows.bat
REM
REM   DESCRIPTION: Remove temporary LaTeX build files from the repository.
REM                This script safely removes LaTeX temporary and auxiliary files
REM                from the current directory, Ausarbeitung, and Vortrag subdirectories.
REM
REM       OPTIONS: None
REM
REM         FILES: Removes .aux, .log, .lof, .gz, .toc, .bak~, .bbl, .bcf, .blg,
REM                .lot, .out, .xml, .acn, .acr, .alg, .glg, .glo, .gls, .gug,
REM                .guo, .gus, .ist, .llg, .llo, .lls, .lug, .luo, .lus, .mog,
REM                .moo, .mos, .xdy, .mw, .synctex.gz, .fdb_latexmk, .fls, .idx,
REM                .ind, .ilg, .dvi, .ps, .pdf
REM
REM ==============================================================================

set SHOW_COMMENTS=true

REM Die Dateipfade müsste man anpassen, wenn man das braucht
if "%SHOW_COMMENTS%"=="true" echo REM Cleaning temporary LaTeX files from current directory

REM Delete files only if they exist
if exist *.aux del /Q *.aux
if exist *.log del /Q *.log
if exist *.lof del /Q *.lof
if exist *.gz del /Q *.gz
if exist *.toc del /Q *.toc
if exist *.bak~ del /Q *.bak~
if exist *.bbl del /Q *.bbl
if exist *.bcf del /Q *.bcf
if exist *.blg del /Q *.blg
if exist *.lot del /Q *.lot
if exist *.out del /Q *.out
if exist *.xml del /Q *.xml
if exist *.acn del /Q *.acn
if exist *.acr del /Q *.acr
if exist *.alg del /Q *.alg
if exist *.glg del /Q *.glg
if exist *.glo del /Q *.glo
if exist *.gls del /Q *.gls
if exist *.gug del /Q *.gug
if exist *.guo del /Q *.guo
if exist *.gus del /Q *.gus
if exist *.ist del /Q *.ist
if exist *.llg del /Q *.llg
if exist *.llo del /Q *.llo
if exist *.lls del /Q *.lls
if exist *.lug del /Q *.lug
if exist *.luo del /Q *.luo
if exist *.lus del /Q *.lus
if exist *.mog del /Q *.mog
if exist *.moo del /Q *.moo
if exist *.mos del /Q *.mos
if exist *.xdy del /Q *.xdy
if exist *.mw del /Q *.mw
if exist *.synctex.gz del /Q *.synctex.gz
if exist *.fdb_latexmk del /Q *.fdb_latexmk
if exist *.fls del /Q *.fls
if exist *.idx del /Q *.idx
if exist *.ind del /Q *.ind
if exist *.ilg del /Q *.ilg
if exist *.dvi del /Q *.dvi
if exist *.ps del /Q *.ps
if exist *.nav del /Q *.nav
if exist *.snm del /Q *.snm

REM Get repository root directory
set REPO_ROOT=%~dp0..

REM Check if Ausarbeitung directory exists before changing to it
if "%SHOW_COMMENTS%"=="true" echo REM Checking for Ausarbeitung directory

if exist "%REPO_ROOT%\Ausarbeitung" (
    REM Wechsel in das Verzeichnis 'Ausarbeitung'
    if "%SHOW_COMMENTS%"=="true" echo REM Changing to 'Ausarbeitung' directory
    pushd "%REPO_ROOT%\Ausarbeitung"

    REM Löschen der gleichen temporären Dateien im Zielverzeichnis
    if "%SHOW_COMMENTS%"=="true" echo REM Cleaning temporary LaTeX files from Ausarbeitung directory
    
    if exist *.aux del /Q *.aux
    if exist *.log del /Q *.log
    if exist *.lof del /Q *.lof
    if exist *.gz del /Q *.gz
    if exist *.toc del /Q *.toc
    if exist *.bak~ del /Q *.bak~
    if exist *.bbl del /Q *.bbl
    if exist *.bcf del /Q *.bcf
    if exist *.blg del /Q *.blg
    if exist *.lot del /Q *.lot
    if exist *.out del /Q *.out
    if exist *.xml del /Q *.xml
    if exist *.acn del /Q *.acn
    if exist *.acr del /Q *.acr
    if exist *.alg del /Q *.alg
    if exist *.glg del /Q *.glg
    if exist *.glo del /Q *.glo
    if exist *.gls del /Q *.gls
    if exist *.gug del /Q *.gug
    if exist *.guo del /Q *.guo
    if exist *.gus del /Q *.gus
    if exist *.ist del /Q *.ist
    if exist *.llg del /Q *.llg
    if exist *.llo del /Q *.llo
    if exist *.lls del /Q *.lls
    if exist *.lug del /Q *.lug
    if exist *.luo del /Q *.luo
    if exist *.lus del /Q *.lus
    if exist *.mog del /Q *.mog
    if exist *.moo del /Q *.moo
    if exist *.mos del /Q *.mos
    if exist *.xdy del /Q *.xdy
    if exist *.mw del /Q *.mw
    if exist *.synctex.gz del /Q *.synctex.gz
    if exist *.fdb_latexmk del /Q *.fdb_latexmk
    if exist *.fls del /Q *.fls
    if exist *.idx del /Q *.idx
    if exist *.ind del /Q *.ind
    if exist *.ilg del /Q *.ilg
    if exist *.dvi del /Q *.dvi
    if exist *.ps del /Q *.ps
    if exist *.nav del /Q *.nav
    if exist *.snm del /Q *.snm
    
    popd
) else (
    if "%SHOW_COMMENTS%"=="true" echo REM Warning: Ausarbeitung directory not found, skipping
)

REM Check if Vortrag directory exists before changing to it
if "%SHOW_COMMENTS%"=="true" echo REM Checking for Vortrag directory

if exist "%REPO_ROOT%\Vortrag" (
    REM Wechsel in das Verzeichnis 'Vortrag'
    if "%SHOW_COMMENTS%"=="true" echo REM Changing to 'Vortrag' directory
    pushd "%REPO_ROOT%\Vortrag"

    REM Löschen der gleichen temporären Dateien im Zielverzeichnis
    if "%SHOW_COMMENTS%"=="true" echo REM Cleaning temporary LaTeX files from Vortrag directory
    
    if exist *.aux del /Q *.aux
    if exist *.log del /Q *.log
    if exist *.lof del /Q *.lof
    if exist *.gz del /Q *.gz
    if exist *.toc del /Q *.toc
    if exist *.bak~ del /Q *.bak~
    if exist *.bbl del /Q *.bbl
    if exist *.bcf del /Q *.bcf
    if exist *.blg del /Q *.blg
    if exist *.lot del /Q *.lot
    if exist *.out del /Q *.out
    if exist *.xml del /Q *.xml
    if exist *.acn del /Q *.acn
    if exist *.acr del /Q *.acr
    if exist *.alg del /Q *.alg
    if exist *.glg del /Q *.glg
    if exist *.glo del /Q *.glo
    if exist *.gls del /Q *.gls
    if exist *.gug del /Q *.gug
    if exist *.guo del /Q *.guo
    if exist *.gus del /Q *.gus
    if exist *.ist del /Q *.ist
    if exist *.llg del /Q *.llg
    if exist *.llo del /Q *.llo
    if exist *.lls del /Q *.lls
    if exist *.lug del /Q *.lug
    if exist *.luo del /Q *.luo
    if exist *.lus del /Q *.lus
    if exist *.mog del /Q *.mog
    if exist *.moo del /Q *.moo
    if exist *.mos del /Q *.mos
    if exist *.xdy del /Q *.xdy
    if exist *.mw del /Q *.mw
    if exist *.synctex.gz del /Q *.synctex.gz
    if exist *.fdb_latexmk del /Q *.fdb_latexmk
    if exist *.fls del /Q *.fls
    if exist *.idx del /Q *.idx
    if exist *.ind del /Q *.ind
    if exist *.ilg del /Q *.ilg
    if exist *.dvi del /Q *.dvi
    if exist *.ps del /Q *.ps
    if exist *.nav del /Q *.nav
    if exist *.snm del /Q *.snm
    
    popd
) else (
    if "%SHOW_COMMENTS%"=="true" echo REM Warning: Vortrag directory not found, skipping
)

echo.
echo === Cleanup complete ===
