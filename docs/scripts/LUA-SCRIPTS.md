# Lua Scripts Reference

This document describes the Lua utility scripts in `scripts/` that use the
Lua 5.5.0 interpreter bundled in `lua-5.5.0/`.

> **Building the interpreter** (done automatically in CI):
> ```bash
> cd lua-5.5.0 && make linux -j$(nproc)
> # Binary produced: lua-5.5.0/src/lua
> ```
> The compiled binary is excluded from version control (`.gitignore`).

---

## `scripts/word-count.lua` — LaTeX Word Counter

Strips LaTeX markup from `.tex` files and counts body words.

### Usage

```bash
# Default: counts words in both main documents
lua-5.5.0/src/lua scripts/word-count.lua

# Explicit file list
lua-5.5.0/src/lua scripts/word-count.lua Ausarbeitung/Ausarbeitung.tex Vortrag/Vortrag.tex
```

### Sample Output

```
File                                                     Words
-----------------------------------------------------------------
Ausarbeitung/Ausarbeitung.tex                            3.434
Vortrag/Vortrag.tex                                      1.121
-----------------------------------------------------------------
Total                                                    4.555
```

### What Is Stripped

The following content is excluded from the word count so that only body text
is counted:

| Stripped content | Example |
|---|---|
| LaTeX commands with arguments | `\textbf{text}`, `\cite{key}` |
| Inline math | `$x + y$` |
| Display math | `$$\int f\,dx$$` |
| Named environments | `equation`, `align`, `lstlisting`, `tikzpicture`, `figure`, `table`, … |
| Remaining braces and brackets | `{`, `}`, `[`, `]` |
| Comment lines | `% …` |

### Exit Codes

| Code | Meaning |
|---|---|
| `0` | All files processed successfully |
| `1` | One or more files could not be opened |

---

## `scripts/check-bib.lua` — Bibliography Validator

Validates required BibTeX fields for every entry in a `.bib` file and
reports errors and warnings with **file and line numbers**.

### Usage

```bash
# Default: checks Ausarbeitung/Ausarbeitung.bib
lua-5.5.0/src/lua scripts/check-bib.lua

# Explicit file list
lua-5.5.0/src/lua scripts/check-bib.lua Ausarbeitung/Ausarbeitung.bib
```

### Sample Output (no issues)

```
Ausarbeitung/Ausarbeitung.bib                        20 entries,  0 errors,  0 warnings
```

### Sample Output (with issues)

```
[ERROR] Ausarbeitung/Ausarbeitung.bib:153 @unpublished{DalItter2026}: missing required field 'note'
[ERROR] Ausarbeitung/Ausarbeitung.bib:161 @article{DalItter2021}: missing required field 'journal'
Ausarbeitung/Ausarbeitung.bib                        20 entries,  2 errors,  0 warnings
```

### Required Fields per Entry Type

| Entry type | Required fields |
|---|---|
| `@article` | `author`, `title`, `journal`, `year` |
| `@book` | `author`, `title`, `publisher`, `year` |
| `@inbook` | `author`, `title`, `chapter`, `publisher`, `year` |
| `@incollection` | `author`, `title`, `booktitle`, `year` |
| `@inproceedings` | `author`, `title`, `booktitle`, `year` |
| `@proceedings` | `title`, `year` |
| `@phdthesis` | `author`, `title`, `school`, `year` |
| `@mastersthesis` | `author`, `title`, `school`, `year` |
| `@techreport` | `author`, `title`, `institution`, `year` |
| `@manual` | `title` |
| `@unpublished` | `author`, `title`, `note` |
| `@misc` | *(none required)* |
| `@online` | `url` |

Additionally the validator checks:

- **Missing year** — warns for any entry (except `@misc` and `@online`) without a `year` field
- **Year format** — warns when `year` is present but is not a 4-digit number (e.g. `26` instead of `2026`)
- **Duplicate keys** — errors when the same key appears more than once (case-insensitive)
- **URL format** — warns when an `@online` entry has a `url` that does not start with `http://`, `https://`, or `ftp://`

### CI Integration

The `bibliography-check` job in `.github/workflows/bibcheck.yml` builds Lua
from source and then runs this script as a required CI step, followed by a
cross-reference check:

```yaml
- name: Build Lua interpreter
  run: cd lua-5.5.0 && make linux -j$(nproc)

- name: Validate required .bib fields (Lua)
  run: lua-5.5.0/src/lua scripts/check-bib.lua Ausarbeitung/Ausarbeitung.bib

- name: Cross-reference check (cited keys exist in .bib)
  run: |
    # Verifies every \cite{key} in Ausarbeitung/ and Vortrag/ exists in the .bib
```

### Exit Codes

| Code | Meaning |
|---|---|
| `0` | All entries valid |
| `1` | One or more errors found, or a file could not be opened |

---

## Lua Interpreter Version

The repository includes the complete source of **Lua 5.5.0** (released
15 Dec 2025) in `lua-5.5.0/`. It is compiled from source in CI rather than
relying on the runner's system Lua, which ensures a consistent, version-pinned
interpreter across all platforms.

The compiled binary and all intermediate object files are excluded from the
repository via `.gitignore`:

```
lua-5.5.0/src/lua
lua-5.5.0/src/luac
lua-5.5.0/src/*.o
lua-5.5.0/src/liblua.a
```
