# Documentation Index

This file is the central index for all documentation in this repository.
Everything is kept in its original location — this index only links to it.

---

## 📋 Quick Reference

| Document | Location | Description |
|---|---|---|
| **README** | [`README.md`](../README.md) | Project overview, build instructions, prerequisites |
| **Contributing** | [`CONTRIBUTING.md`](../CONTRIBUTING.md) | Contribution workflow, coding conventions |
| **Security Policy** | [`SECURITY.md`](../SECURITY.md) | Supported versions, vulnerability reporting |
| **Architecture** | [`docs/ARCHITECTURE.md`](ARCHITECTURE.md) | Technical architecture, build pipeline |
| **Changelog** | [`docs/CHANGELOG.md`](CHANGELOG.md) | Version history |

---

## 🗂️ All Documentation by Category

### Project Root
- [`README.md`](../README.md) — Entry point: structure, build, scripts, badges
- [`CONTRIBUTING.md`](../CONTRIBUTING.md) — PR process, LaTeX conventions, quality checks
- [`SECURITY.md`](../SECURITY.md) — Security policy and responsible disclosure
- [`DISCLAIMER.txt`](../DISCLAIMER.txt) — Warranty disclaimer

### Technical Architecture & Design
- [`docs/ARCHITECTURE.md`](ARCHITECTURE.md) — LaTeX pipeline, CI workflows, directory layout
- [`docs/PROJECT_REVIEW_SUMMARY.md`](PROJECT_REVIEW_SUMMARY.md) — Post-audit review results

### Changelog & Release Notes
- [`docs/CHANGELOG.md`](CHANGELOG.md) — Keep-a-Changelog formatted version history

### Improvement Summaries (chronological)
- [`docs/improvement/IMPROVEMENTS_SUMMARY_1.0.md`](improvement/IMPROVEMENTS_SUMMARY_1.0.md) — v1.0 improvements (minimal-loss pass)
- [`docs/improvement/IMPROVEMENT_SUMMARY_2.0.md`](improvement/IMPROVEMENT_SUMMARY_2.0.md) — v2.0 improvements (critical review pass)
- [`docs/improvement/IMPROVEMENT_SUMMARY_3.0.md`](improvement/IMPROVEMENT_SUMMARY_3.0.md) — v3.0 improvements (spellcheck, biber, Lua, labels)

### Scripts Documentation
- [`docs/scripts/LUA-SCRIPTS.md`](scripts/LUA-SCRIPTS.md) — `word-count.lua` and `check-bib.lua` reference

### LaTeX Installation Guides
- [`latex_install/LaTeX-Install.md`](../latex_install/LaTeX-Install.md) — English installation guide
- [`latex_install/LaTeX-Install.de.md`](../latex_install/LaTeX-Install.de.md) — Deutsche Installationsanleitung

### Wiki (auto-synced to GitHub Wiki)
The files under `wiki/` are the authoritative source for the GitHub Wiki pages.

| Wiki Page | Source File |
|---|---|
| Home | [`wiki/Home.md`](../wiki/Home.md) |
| Getting Started | [`wiki/Getting-Started.md`](../wiki/Getting-Started.md) |
| Building PDFs | [`wiki/Building-PDFs.md`](../wiki/Building-PDFs.md) |
| CI/CD Workflows | [`wiki/CI-CD-Workflows.md`](../wiki/CI-CD-Workflows.md) |
| Contributing | [`wiki/Contributing.md`](../wiki/Contributing.md) |
| FAQ | [`wiki/FAQ.md`](../wiki/FAQ.md) |
| Troubleshooting | [`wiki/Troubleshooting.md`](../wiki/Troubleshooting.md) |
| Project Structure | [`wiki/Project-Structure.md`](../wiki/Project-Structure.md) |
| Wiki Sync Info | [`wiki/Wiki-Sync.md`](../wiki/Wiki-Sync.md) |

### Historical / Archive
- [`archive/README.md`](../archive/README.md) — Branch consolidation history
- [`archive/CONSOLIDATION-SUMMARY.md`](../archive/CONSOLIDATION-SUMMARY.md) — Consolidation summary
- [`archive/branch-snapshots/`](../archive/branch-snapshots/) — Per-branch milestone snapshots
- [`branch_cleanup/`](../branch_cleanup/) — Branch deletion guides and checklists
- [`legacy/README.md`](../legacy/README.md) — Deprecated files

### Review
- [`review/REVIEW-SUMMARY.md`](../review/REVIEW-SUMMARY.md) — Review summary

---

## 🔧 Configuration Files (with inline docs)

| File | Purpose |
|---|---|
| [`cspell.json`](../cspell.json) | Spell-checker configuration (dictionaries, ignore patterns, word list) |
| [`.github/labels.yml`](../.github/labels.yml) | Repository label definitions (synced by `sync-labels` workflow) |
| [`.github/labeler.yml`](../.github/labeler.yml) | Automatic PR labelling rules |
| [`.github/dependabot.yml`](../.github/dependabot.yml) | Dependabot update schedule |
| [`Ausarbeitung/.latexmkrc`](../Ausarbeitung/.latexmkrc) | latexmk settings for Ausarbeitung |
| [`Vortrag/.latexmkrc`](../Vortrag/.latexmkrc) | latexmk settings for Vortrag |

---

## 🤖 CI/CD Workflows

| Workflow | File | Trigger |
|---|---|---|
| Build & Publish PDFs | [`.github/workflows/build-and-publish-pdfs.yml`](../.github/workflows/build-and-publish-pdfs.yml) | push / PR |
| LaTeX Lint | [`.github/workflows/lint.yml`](../.github/workflows/lint.yml) | push / PR |
| Spellcheck | [`.github/workflows/spellcheck.yml`](../.github/workflows/spellcheck.yml) | push / PR |
| Bibliography Check | [`.github/workflows/bibcheck.yml`](../.github/workflows/bibcheck.yml) | push / PR |
| Format | [`.github/workflows/format.yml`](../.github/workflows/format.yml) | push to main |
| Docker Image | [`.github/workflows/docker-image.yml`](../.github/workflows/docker-image.yml) | push / PR |
| CodeQL Analysis | [`.github/workflows/codeql-analysis.yml`](../.github/workflows/codeql-analysis.yml) | push / PR / schedule |
| Label PRs | [`.github/workflows/label.yml`](../.github/workflows/label.yml) | PR |
| Sync Labels | [`.github/workflows/sync-labels.yml`](../.github/workflows/sync-labels.yml) | push to labels.yml |
| Publish Wiki | [`.github/workflows/publish-wiki.yml`](../.github/workflows/publish-wiki.yml) | push to wiki/ |
| Greetings | [`.github/workflows/greetings.yml`](../.github/workflows/greetings.yml) | first issue / PR |
| Stale | [`.github/workflows/stale.yml`](../.github/workflows/stale.yml) | schedule |
| Summary | [`.github/workflows/summary.yml`](../.github/workflows/summary.yml) | push / PR |

---

*This index is maintained alongside the source. When adding new documentation files,
add a corresponding entry here.*
