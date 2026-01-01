# Troubleshooting

Solutions to common problems and issues when working with this project.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Build Errors](#build-errors)
- [LaTeX Compilation Problems](#latex-compilation-problems)
- [Bibliography Issues](#bibliography-issues)
- [Git and GitHub Issues](#git-and-github-issues)
- [CI/CD Failures](#cicd-failures)
- [Editor Problems](#editor-problems)
- [Platform-Specific Issues](#platform-specific-issues)

## Installation Issues

### LaTeX Distribution Not Found

**Symptom**: Command not found: `pdflatex`, `latex`, or `latexmk`

**Solution**:

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install texlive texlive-latex-extra

# macOS
brew install --cask mactex
# Or download from https://www.tug.org/mactex/

# Windows
# Download TeX Live from https://www.tug.org/texlive/
# Or MiKTeX from https://miktex.org/
```

After installation, verify:

```bash
pdflatex --version
latexmk --version
```

### Biber Not Found

**Symptom**: `biber: command not found`

**Solution**:

```bash
# Ubuntu/Debian
sudo apt-get install biber

# macOS
brew install biber
# Or it's included in MacTeX

# Windows
# Included in TeX Live/MiKTeX
# If missing, reinstall or update TeX distribution
```

### Perl Not Found (for latexmk)

**Symptom**: `perl: command not found`

**Solution**:

```bash
# Ubuntu/Debian
sudo apt-get install perl

# macOS (usually pre-installed)
# If missing:
brew install perl

# Windows
# Download from https://www.perl.org/get.html
# Or use Strawberry Perl
```

### Missing LaTeX Packages

**Symptom**: `! LaTeX Error: File 'package.sty' not found.`

**Solution**:

```bash
# Ubuntu/Debian - Install common packages
sudo apt-get install texlive-latex-extra texlive-science texlive-fonts-extra

# macOS - MacTeX includes most packages
# If needed, use TeX Live Utility to install

# Windows MiKTeX - Auto-install on first use
# Or manually: MiKTeX Console → Packages → Install

# Manual package installation
tlmgr install package-name
```

Common missing packages and solutions:

| Error | Package | Install Command |
|-------|---------|----------------|
| `biblatex.sty not found` | biblatex | `tlmgr install biblatex` |
| `babel.sty not found` | babel | `tlmgr install babel` |
| `hyperref.sty not found` | hyperref | `tlmgr install hyperref` |

## Build Errors

### Build Fails with "Undefined Control Sequence"

**Symptom**: `! Undefined control sequence. l.42 \somecommand`

**Cause**: Missing package or typo in command

**Solution**:

1. Check command spelling:
   ```latex
   % Wrong
   \textbold{text}
   
   % Correct
   \textbf{text}
   ```

2. Add required package:
   ```latex
   % For \url
   \usepackage{hyperref}
   
   % For \SI
   \usepackage{siunitx}
   ```

3. Check log file for package suggestions:
   ```bash
   grep -A 5 "Undefined control sequence" Ausarbeitung.log
   ```

### Build Hangs or Takes Forever

**Symptom**: Build process doesn't complete

**Cause**: Infinite loop, missing `\end`, or interactive error

**Solution**:

1. Use non-interactive mode:
   ```bash
   latexmk -pdf -interaction=nonstopmode Ausarbeitung.tex
   ```

2. Check for unmatched environments:
   ```latex
   % Bad
   \begin{itemize}
     \item One
   % Missing \end{itemize}
   ```

3. Review log file for errors:
   ```bash
   less Ausarbeitung/Ausarbeitung.log
   # Press / to search, q to quit
   ```

4. Kill stuck process:
   ```bash
   # Find process
   ps aux | grep latex
   
   # Kill it
   kill -9 PID
   ```

### "Emergency Stop" Error

**Symptom**: `! Emergency stop.`

**Cause**: Fatal LaTeX error

**Solution**:

1. Check the line number in error message
2. Look for:
   - Unmatched braces `{` or `}`
   - Missing `\end{document}`
   - Corrupted package installation

3. Rebuild from scratch:
   ```bash
   latexmk -C  # Clean all
   latexmk -pdf Ausarbeitung.tex
   ```

## LaTeX Compilation Problems

### Undefined References

**Symptom**: `[??]` in PDF or "Reference 'label' on page X undefined"

**Cause**: Incomplete LaTeX runs

**Solution**:

Run LaTeX multiple times:

```bash
# Automatic (recommended)
latexmk -pdf Ausarbeitung.tex

# Manual
pdflatex Ausarbeitung.tex
pdflatex Ausarbeitung.tex  # Second run resolves references
```

### Images Not Appearing

**Symptom**: Empty space where image should be, or "File not found" error

**Solution**:

1. Check image path:
   ```latex
   % Relative to .tex file
   \includegraphics{image.pdf}
   
   % Subdirectory
   \includegraphics{figures/image.pdf}
   
   % Absolute path (avoid)
   \includegraphics{/full/path/to/image.pdf}
   ```

2. Verify image file exists:
   ```bash
   ls -la image.pdf
   ```

3. Check image format:
   ```latex
   % Supported: PDF, PNG, JPG
   % NOT supported by pdflatex: EPS (convert first)
   
   % Convert EPS to PDF
   epstopdf image.eps
   ```

4. Add graphicx package:
   ```latex
   \usepackage{graphicx}
   ```

### German Characters Broken

**Symptom**: ä, ö, ü display as strange characters

**Solution**:

1. Ensure proper encoding in preamble:
   ```latex
   \usepackage[utf8]{inputenc}
   \usepackage[T1]{fontenc}
   \usepackage[ngerman]{babel}
   ```

2. Save file as UTF-8:
   - **TeXstudio**: Options → Configure → Editor → Default Character Encoding → UTF-8
   - **VS Code**: Bottom right corner → Select encoding → Save with Encoding → UTF-8

3. Use LaTeX commands as fallback:
   ```latex
   \"a  % ä
   \"o  % ö
   \"u  % ü
   \ss  % ß
   ```

### Special Characters Causing Errors

**Symptom**: Errors with `_`, `%`, `&`, `$`, `#`

**Solution**: Escape special characters:

```latex
% Wrong
filename_test.txt
50% of the data
$100 dollars

% Correct
filename\_test.txt
50\% of the data
\$100 dollars

% Or use verbatim
\verb|filename_test.txt|
\texttt{filename\_test.txt}
```

### Table Formatting Issues

**Symptom**: Tables misaligned or overflowing

**Solution**:

1. Use proper column specifiers:
   ```latex
   \begin{tabular}{|l|c|r|}  % left, center, right
     \hline
     Left & Center & Right \\
     \hline
   \end{tabular}
   ```

2. For wide tables:
   ```latex
   \usepackage{tabularx}
   
   \begin{tabularx}{\textwidth}{|X|X|X|}
     \hline
     Column 1 & Column 2 & Column 3 \\
     \hline
   \end{tabularx}
   ```

3. Rotate large tables:
   ```latex
   \usepackage{rotating}
   
   \begin{sidewaystable}
     \begin{tabular}{...}
       ...
     \end{tabular}
   \end{sidewaystable}
   ```

## Bibliography Issues

### Citations Not Showing

**Symptom**: `[?]` instead of citation number/key

**Cause**: Bibliography not processed correctly

**Solution**:

1. Ensure you're using Biber (not BibTeX):
   ```bash
   pdflatex Ausarbeitung.tex
   biber Ausarbeitung  # NOT bibtex
   pdflatex Ausarbeitung.tex
   pdflatex Ausarbeitung.tex
   ```

2. Configure TeXstudio for Biber:
   - Options → Configure TeXstudio → Build
   - Default Bibliography Tool → **Biber**

3. Check `.bib` file syntax:
   ```bibtex
   @article{key,
     author = {Author Name},
     title = {Title},
     journal = {Journal},
     year = {2020}
   }
   ```

4. Verify citation key matches:
   ```latex
   % In .bib file
   @article{smith2020,
     ...
   }
   
   % In .tex file
   \cite{smith2020}  % Must match exactly
   ```

### Biber Errors

**Symptom**: "ERROR - Cannot find control file 'Ausarbeitung.bcf'"

**Solution**:

1. Run PDFLaTeX first to generate `.bcf`:
   ```bash
   pdflatex Ausarbeitung.tex
   biber Ausarbeitung
   pdflatex Ausarbeitung.tex
   ```

2. Clean and rebuild:
   ```bash
   latexmk -C
   latexmk -pdf Ausarbeitung.tex
   ```

**Symptom**: "ERROR - BibTeX subsystem: /.../Ausarbeitung.bib_####.utf8, line ##, syntax error"

**Solution**: Fix BibTeX syntax error. Common mistakes:

```bibtex
% Missing comma
@article{key
  author = {Name}
  title = {Title}  % ERROR: Missing comma after author
}

% Correct
@article{key,
  author = {Name},
  title = {Title}
}

% Unbalanced braces
@article{key,
  title = {Title with {emphasis}  % ERROR: Missing }
}

% Duplicate keys
@article{smith2020,
  ...
}
@article{smith2020,  % ERROR: Duplicate
  ...
}
```

### Bibliography Not Sorted Correctly

**Solution**: Configure biblatex sorting:

```latex
\usepackage[sorting=nyt]{biblatex}  % Name, year, title
% or
\usepackage[sorting=ynt]{biblatex}  % Year, name, title
% or
\usepackage[sorting=none]{biblatex}  % Citation order
```

## Git and GitHub Issues

### Cannot Push - Permission Denied

**Symptom**: `Permission denied (publickey)` or `403 Forbidden`

**Solution**:

1. Use HTTPS with token:
   ```bash
   git remote set-url origin https://github.com/username/repo.git
   ```

2. Or set up SSH keys:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   # Add to GitHub: Settings → SSH Keys
   ```

3. Or use GitHub CLI:
   ```bash
   gh auth login
   ```

### Merge Conflicts

**Symptom**: `CONFLICT (content): Merge conflict in file.tex`

**Solution**:

1. View conflicts:
   ```bash
   git status
   ```

2. Edit conflicted files:
   ```latex
   <<<<<<< HEAD
   Your changes
   =======
   Their changes
   >>>>>>> branch-name
   ```

3. Choose or combine changes, remove markers

4. Mark as resolved:
   ```bash
   git add file.tex
   git commit -m "Resolve merge conflict"
   ```

### Accidentally Committed Build Artifacts

**Symptom**: PDFs, aux files in git history

**Solution**:

```bash
# Remove from index but keep locally
git rm --cached *.pdf *.aux *.log

# Ensure .gitignore includes them
echo "*.pdf" >> .gitignore
echo "*.aux" >> .gitignore

git add .gitignore
git commit -m "Remove build artifacts, update .gitignore"
git push
```

### Large Files Rejected

**Symptom**: `remote: error: File too large` or `remote: error: GH001`

**Solution**:

1. Don't commit large PDFs, images, or data files
2. Use Git LFS for large files:
   ```bash
   git lfs install
   git lfs track "*.pdf"
   git add .gitattributes
   ```

3. Or remove from history:
   ```bash
   git filter-branch --force --index-filter \
     "git rm --cached --ignore-unmatch large-file.pdf" \
     --prune-empty --tag-name-filter cat -- --all
   ```

## CI/CD Failures

### Build Workflow Fails

**Check logs**:
1. Go to [Actions tab](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions)
2. Click failed run
3. Expand failed step

**Common causes and solutions**:

| Error | Cause | Solution |
|-------|-------|----------|
| Package not found | Missing TeX package | Add to workflow YAML |
| LaTeX error | Syntax error in .tex | Fix locally and push |
| Timeout | Build takes too long | Simplify document or increase timeout |

### Spell Check Fails

**View errors**:
```bash
# Run locally
npx cspell "**/*.tex" "**/*.md"
```

**Solutions**:

1. Fix actual typos
2. Add technical terms to dictionary:
   ```json
   // cspell.json
   {
     "words": [
       "LaTeX",
       "BibTeX",
       "customterm"
     ]
   }
   ```

3. Ignore specific line:
   ```latex
   % cspell:disable-next-line
   \newcommand{\specialterm}{...}
   ```

### BibTeX Check Fails

**Run locally**:
```bash
biber --tool --validate-datamodel Ausarbeitung.bib
```

**Fix syntax errors** as shown in [Bibliography Issues](#bibliography-issues)

## Editor Problems

### TeXstudio Not Finding Biber

**Solution**: Configure manually

1. Options → Configure TeXstudio → Commands
2. Set Biber path: `/usr/bin/biber` (Linux) or find full path
3. Build → Default Bibliography Tool → Biber

### VS Code LaTeX Workshop Issues

**Solution**: Configure in `.vscode/settings.json`:

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": ["-pdf", "-interaction=nonstopmode", "%DOC%"]
    }
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "latexmk",
      "tools": ["latexmk"]
    }
  ]
}
```

### Syntax Highlighting Broken

**TeXstudio**: Options → Configure → Syntax Highlighting → Reset to Defaults

**VS Code**: Reinstall LaTeX Workshop extension

## Platform-Specific Issues

### Windows: Scripts Don't Run

**Solution**: Use batch files or install Git Bash

```bash
# Use Windows script
cleanup\Remove_Junk_Windows.bat

# Or install Git Bash
# Then run Linux scripts
bash scripts/generatePdf.sh
```

### macOS: Permission Denied

**Solution**: Make scripts executable

```bash
chmod +x scripts/*.sh
./scripts/generatePdf.sh
```

### Linux: Font Issues

**Solution**: Install additional fonts

```bash
sudo apt-get install texlive-fonts-recommended texlive-fonts-extra
fc-cache -fv
```

## Getting Additional Help

If your issue isn't covered here:

1. Check the [FAQ](FAQ.md)
2. Search [existing issues](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/issues)
3. Review [LaTeX documentation](https://www.latex-project.org/help/documentation/)
4. Ask on [TeX StackExchange](https://tex.stackexchange.com/)
5. Create a new issue with detailed information

### Creating a Good Bug Report

Include:
- **Error message**: Full text
- **Environment**: OS, LaTeX distribution, versions
- **Steps to reproduce**: Exact commands run
- **Log files**: Relevant portions of `.log` files
- **Minimal example**: Simplest code that reproduces the issue

---

[← Back to Wiki Home](Home.md)
