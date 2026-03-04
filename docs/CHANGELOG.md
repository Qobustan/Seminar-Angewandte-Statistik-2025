# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `scripts/word-count.lua` — Lua script that strips LaTeX markup and counts body words in `.tex` files
- `scripts/check-bib.lua` — Lua script that validates required BibTeX fields per entry type, reporting errors with file name and line number
- `docs/README.md` — Central documentation index linking all docs across the repository
- `docs/scripts/LUA-SCRIPTS.md` — Reference documentation for the two new Lua scripts
- `docs/improvement/IMPROVEMENT_SUMMARY_3.0.md` — Full record of v3.0 fixes
- `lua` label added to `.github/labels.yml` and `.github/labeler.yml` for Lua-related PRs
- `contents: read` permission added to `sync-labels.yml` so `actions/checkout@v4` succeeds
- `bibcheck.yml` now builds Lua from source and validates `.bib` required fields in CI
- `spellcheck.yml` extended to also check `.sh`, `.py`, and `.lua` files
- `lua-5.5.0/src/**` and `lua-5.5.0/doc/**` added to `cspell.json` ignore paths
- 40+ German/statistical/LaTeX domain terms added to `cspell.json` wordlist

### Fixed
- **Spellchecker silently passed all files**: two `ignoreRegExpList` patterns were applied case-insensitively by cspell, matching every word; fixed by wrapping in `/pattern/` for case-sensitive matching
- `Sonderzeichung` → `Sonderzeichen` in two `Besprechung/` header files
- `multivariante` → `multivariate` in `Besprechung/.../Stabil/Ausarbeitung/Ausarbeitung.tex`
- `@unpublished{DalItter2026}`: added missing required `note` field
- `@article{DalItter2021}`: added missing required `journal` field
- **Documentation inconsistency**: seven wiki/docs files incorrectly documented `backend=bibtex`; all corrected to `backend=biber` (matching actual `.tex` and `.latexmkrc` files)

- New `\section{Fallbeispiel: Gewässermessungen der Itter}` in `Ausarbeitung/Ausarbeitung.tex` with spectrophotometric measurement figures (reusing Vortrag images) and motivating discussion
- New `\subsection*{Ausgangssituation und Zielsetzung}` in Einleitung section of `Ausarbeitung/Ausarbeitung.tex` with formal model setup ($X_1,\dots,X_n \sim F$)
- New `\subsection*{Empirische Verteilungsfunktion}` in Rosenblatt section of `Ausarbeitung/Ausarbeitung.tex` with explicit definition of $F_n$
- New `\subsection{O-Notation}` in KDE section of `Ausarbeitung/Ausarbeitung.tex` explaining Big-O notation used in asymptotic analysis
- New `\subsection{Vorteile der Kerndichteschätzung}` after KDE als Faltung in `Ausarbeitung/Ausarbeitung.tex`
- New `\subsection{Vorteile und Grenzen der nichtparametrischen Regression}` in NP Regression section of `Ausarbeitung/Ausarbeitung.tex`
- New `\subsection{Bias-Problem an den Datengrenzen}` with local polynomial regression solution in `Ausarbeitung/Ausarbeitung.tex`
- New `\subsection{Strukturelle Sicht: Nadaraya-Watson als Quotient von KDE}` in NP Regression section of `Ausarbeitung/Ausarbeitung.tex`
- New `\subsection{Gemeinsames Prinzip von Kerndichteschätzung und nichtparametrischer Regression}` in `Ausarbeitung/Ausarbeitung.tex`
- 5 new bibliography entries in `Ausarbeitung/Ausarbeitung.bib`: `DalItter2026`, `DalItter2021`, `SMI21`, `dal2023probtest`, `lang2004civ`
- New Beamer slide "Fallbeispiel: Gewässermessungen der Itter" in the "Einleitung & Motivation" section of `Vortrag/Vortrag.tex`, illustrating why a single distribution assumption is insufficient
- `Vortrag/img/` directory with `README.md` placeholder for the measurement images (`messung_itter_1.png`, `messung_itter_2.png`)
- Two new bibliography entries in `Vortrag/Vortrag.bib`: `DalItter2026` and `DalItter2021`
- Pause (`\ifpauseswitch\pause\fi`) on the new Fallbeispiel slide before the concluding Fazit block
- Comprehensive project documentation improvements
- CHANGELOG.md for version tracking
- Pull request template for consistent contributions
- CODEOWNERS file for ownership tracking
- Architecture documentation

### Changed
- `Robuste Lineare Regression` promoted from `\subsection` to `\section` in `Ausarbeitung/Ausarbeitung.tex` to match Vortrag structure
- `\section{Zusammenfassung und Fazit}` expanded in `Ausarbeitung/Ausarbeitung.tex`: added 5-bullet summary from Vortrag, restored rich content (Praktische Anwendungen, Grenzen und Herausforderungen, Ausblick, final paragraph)
- `Vortrag/Vortrag.bib` trimmed to three entries only: `BüningTrenkler+1994`, `DalItter2026`, `DalItter2021`; removed `Silverman1986`, `Rosenblatt1956`, `Epanechnikov1969`, `NadarayaWatson1964`, `Watson1964`, `Sen1968`, `Wasserman2006`

## [1.0.0] - 2026-02-12

### Added
- Initial LaTeX project structure for Applied Statistics seminar
- Ausarbeitung (written elaboration) LaTeX sources
- Vortrag (Beamer presentation) LaTeX sources
- Comprehensive README with build instructions
- Contributing guidelines (CONTRIBUTING.md)
- Security policy (SECURITY.md)
- Disclaimer (DISCLAIMER.txt)
- Docker support for containerized PDF generation
- GitHub Actions CI/CD workflows:
  - Automated PDF building with pdflatex and lualatex support
  - LaTeX linting with chktex
  - Spell checking with cspell
  - Bibliography validation
  - Wiki publishing automation
- Build and cleanup scripts for Windows, Linux, and macOS
- Comprehensive bibliography with 15+ academic references
- German language support with proper typography
- MIT License

### Fixed
- Grammatical errors in Ausarbeitung
- Duplicate slide in Vortrag presentation
- Unprofessional formatting (pink colorbox replaced with proper LaTeX)
- Bibliography warnings and csquotes integration
- Duplicate package declarations in headers

### Changed
- Enhanced bibliography from 1 to 15 comprehensive academic references
- Improved citation style throughout both documents
- Professional academic formatting standards applied
- Updated documentation structure and organization

## Project Information

- **Author:** Yavuzâlp Dal
- **Semester:** Wintersemester 2025/26
- **Topic:** Applied Statistics (Angewandte Statistik)
- **Institution:** Referenced in seminar context
- **Repository:** https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025

## Versioning Notes

- Version numbers follow Semantic Versioning (MAJOR.MINOR.PATCH)
- MAJOR: Incompatible structural changes
- MINOR: Backward-compatible functionality additions
- PATCH: Backward-compatible bug fixes

[Unreleased]: https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/compare/main...HEAD
[1.0.0]: https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/releases/tag/v1.0.0
