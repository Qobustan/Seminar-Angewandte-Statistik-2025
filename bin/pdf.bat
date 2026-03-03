@echo off
REM SPDX-License-Identifier: MIT
REM SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
REM
REM Erzeugt die PDFs mit pdflatex.
REM Delegiert an scripts\generatePdf.bat.
REM
REM Verwendung:
REM   bin\pdf.bat

call "%~dp0..\scripts\generatePdf.bat" %*
