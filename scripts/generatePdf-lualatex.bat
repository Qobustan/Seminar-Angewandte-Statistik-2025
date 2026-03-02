@echo off
REM SPDX-License-Identifier: MIT
REM SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
REM
REM Convenience wrapper: generate PDFs using LuaLaTeX.
REM Calls the main generatePdf.bat with LATEX_ENGINE=lualatex so that
REM the existing PDFLaTeX script is left completely unchanged.
REM
REM Usage:
REM   scripts\generatePdf-lualatex.bat
REM
REM Equivalent to:
REM   set LATEX_ENGINE=lualatex
REM   scripts\generatePdf.bat

set LATEX_ENGINE=lualatex
call "%~dp0generatePdf.bat" %*
