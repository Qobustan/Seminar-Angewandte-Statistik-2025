@echo off
REM SPDX-License-Identifier: MIT
REM SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
REM
REM Erzeugt die PDFs mit LuaLaTeX.
REM Delegiert an scripts\generatePdf-lualatex.bat.
REM
REM Verwendung:
REM   bin\lualatex.bat

call "%~dp0..\scripts\generatePdf-lualatex.bat" %*
