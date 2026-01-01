@echo off
REM Script to generate PDFs for Ausarbeitung and Vortrag

setlocal enabledelayedexpansion

echo Building Ausarbeitung...
cd /d "%~dp0..\Ausarbeitung"
pdflatex -interaction=nonstopmode Ausarbeitung.tex
bibtex Ausarbeitung 2>nul
pdflatex -interaction=nonstopmode Ausarbeitung.tex
pdflatex -interaction=nonstopmode Ausarbeitung.tex

echo Building Vortrag...
cd ..\Vortrag
pdflatex -interaction=nonstopmode Vortrag.tex
bibtex Vortrag 2>nul
pdflatex -interaction=nonstopmode Vortrag.tex
pdflatex -interaction=nonstopmode Vortrag.tex

echo PDFs generated successfully!
