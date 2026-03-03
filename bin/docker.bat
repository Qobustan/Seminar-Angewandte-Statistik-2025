@echo off
REM SPDX-License-Identifier: MIT
REM SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
REM
REM Startet Docker: Baut das Image und erzeugt die PDFs im Container.
REM
REM Verwendung:
REM   bin\docker.bat [--lualatex]
REM
REM Optionen:
REM   --lualatex   LuaLaTeX statt pdflatex verwenden

setlocal enabledelayedexpansion

set LATEX_ENGINE=pdflatex

if /i "%~1"=="--lualatex" set LATEX_ENGINE=lualatex
if /i "%~1"=="-h"         goto :show_help
if /i "%~1"=="--help"     goto :show_help

goto :main

:show_help
echo Verwendung: %~n0 [--lualatex]
echo.
echo Baut das Docker-Image und generiert die PDFs im Container.
echo.
echo Optionen:
echo   --lualatex   LuaLaTeX statt pdflatex verwenden
echo   -h, --help   Diese Hilfe anzeigen
exit /b 0

:main
echo === Docker PDF-Generierung ===
echo LaTeX-Engine: %LATEX_ENGINE%
echo.

echo [1/2] Baue Docker-Image...
docker build -t latex-seminar:latest "%~dp0.." || exit /b 1

echo.
echo [2/2] Erzeuge PDFs im Container...
docker run --rm ^
    -e LATEX_ENGINE=%LATEX_ENGINE% ^
    -v "%~dp0..\Ausarbeitung:/app/Ausarbeitung" ^
    -v "%~dp0..\Vortrag:/app/Vortrag" ^
    latex-seminar:latest || exit /b 1

echo.
echo === Fertig! PDFs wurden erzeugt. ===
