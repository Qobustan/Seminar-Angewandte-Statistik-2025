@echo off
REM Script to generate PDFs for Ausarbeitung and Vortrag
REM 
REM By default, uses pdflatex for backwards compatibility.
REM To use lualatex, set the LATEX_ENGINE environment variable:
REM     set LATEX_ENGINE=lualatex
REM     generatePdf.bat

setlocal enabledelayedexpansion

REM Determine which LaTeX engine to use (default: pdflatex)
if not defined LATEX_ENGINE set LATEX_ENGINE=pdflatex

REM Validate the engine (security: only allow known-safe values)
REM This prevents command injection by restricting to approved engines only
REM Note: Normalizing to lowercase for consistency with bash script behavior
if /i "%LATEX_ENGINE%"=="pdflatex" set LATEX_ENGINE=pdflatex
if /i "%LATEX_ENGINE%"=="lualatex" set LATEX_ENGINE=lualatex

REM Check if normalization succeeded (if not, it's an invalid engine)
if "%LATEX_ENGINE%"=="pdflatex" goto :engine_ok
if "%LATEX_ENGINE%"=="lualatex" goto :engine_ok

echo Error: Invalid LATEX_ENGINE '%LATEX_ENGINE%'
echo Supported engines: pdflatex, lualatex
echo Defaulting to pdflatex for backwards compatibility
set LATEX_ENGINE=pdflatex

:engine_ok
echo Using LaTeX engine: %LATEX_ENGINE%
echo.

echo Building Ausarbeitung...
cd /d "%~dp0..\Ausarbeitung" || exit /b 1
%LATEX_ENGINE% -interaction=nonstopmode Ausarbeitung.tex || exit /b 1
bibtex Ausarbeitung 2>nul
%LATEX_ENGINE% -interaction=nonstopmode Ausarbeitung.tex || exit /b 1
%LATEX_ENGINE% -interaction=nonstopmode Ausarbeitung.tex || exit /b 1

echo Building Vortrag...
cd /d "%~dp0..\Vortrag" || exit /b 1
%LATEX_ENGINE% -interaction=nonstopmode Vortrag.tex || exit /b 1
bibtex Vortrag 2>nul
%LATEX_ENGINE% -interaction=nonstopmode Vortrag.tex || exit /b 1
%LATEX_ENGINE% -interaction=nonstopmode Vortrag.tex || exit /b 1

echo PDFs generated successfully!
