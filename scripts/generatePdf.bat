@echo off
REM Script to generate PDFs for Ausarbeitung and Vortrag

setlocal enabledelayedexpansion

echo Building Ausarbeitung...
cd /d "%~dp0..\Ausarbeitung" || exit /b 1
pdflatex -interaction=nonstopmode Ausarbeitung.tex || exit /b 1
bibtex Ausarbeitung 2>nul
pdflatex -interaction=nonstopmode Ausarbeitung.tex || exit /b 1
pdflatex -interaction=nonstopmode Ausarbeitung.tex || exit /b 1

echo Building Vortrag...
cd /d "%~dp0..\Vortrag" || exit /b 1
pdflatex -interaction=nonstopmode Vortrag.tex || exit /b 1
bibtex Vortrag 2>nul
pdflatex -interaction=nonstopmode Vortrag.tex || exit /b 1
pdflatex -interaction=nonstopmode Vortrag.tex || exit /b 1

echo PDFs generated successfully!
