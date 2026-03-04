# Frequently Asked Questions (FAQ)

Common questions and answers about the Seminar: Angewandte Statistik 2025 project.

## Table of Contents

- [General Questions](#general-questions)
- [Setup and Installation](#setup-and-installation)
- [Building and Compilation](#building-and-compilation)
- [Git and Version Control](#git-and-version-control)
- [LaTeX Specific](#latex-specific)
- [CI/CD and Automation](#cicd-and-automation)
- [Contributing](#contributing)

## General Questions

### What is this project about?

This repository contains materials for the "Angewandte Statistik" (Applied Statistics) seminar for 2025, including LaTeX sources for written elaboration and presentation slides.

### What license does this project use?

Please refer to the repository's LICENSE file for licensing information.

### Who maintains this project?

The project is maintained by @Qobustan and contributors. See the git commit history for all contributors.

### Can I use this as a template for my own seminar?

Yes! The template branch is preserved for this purpose. However, please review the license and give appropriate attribution.

## Setup and Installation

### Do I need to install LaTeX locally?

Not necessarily. You have several options:

1. **Local installation**: Install TeX Live (Linux/Windows) or MacTeX (macOS)
2. **Docker**: Use the provided Dockerfile
3. **CI/CD only**: Make changes and let GitHub Actions build for you
4. **Online editors**: Use Overleaf or similar (requires manual sync)

See the [Getting Started Guide](Getting-Started.md) for details.

### Which LaTeX distribution should I use?

**Recommended**:
- **Linux**: TeX Live (via package manager)
- **macOS**: MacTeX (most complete)
- **Windows**: TeX Live or MiKTeX

**Minimum requirements**:
- PDFLaTeX compiler
- Biber (bibliography processor — this project uses `backend=biber`)
- Common LaTeX packages (listed in workflow files)

### Do I need a specific editor?

No, you can use any text editor. Popular choices:

- **TeXstudio**: Feature-rich LaTeX IDE (recommended for beginners)
- **Visual Studio Code**: General purpose with LaTeX Workshop extension
- **Vim/Emacs**: With LaTeX plugins
- **Overleaf**: Online collaborative editor

See [Getting Started](Getting-Started.md) for editor configuration.

### What if I can't install LaTeX?

Use Docker:

```bash
docker build -t latex-builder .
docker run --rm -v $(pwd):/workspace latex-builder
```

Or rely on GitHub Actions to build PDFs automatically.

## Building and Compilation

### How do I build the PDFs?

Multiple methods:

```bash
# Method 1: Project script
./scripts/generatePdf.sh

# Method 2: latexmk (recommended)
cd Ausarbeitung && latexmk -pdf Ausarbeitung.tex

# Method 3: Manual (this project uses biber backend)
pdflatex Ausarbeitung.tex
biber Ausarbeitung
pdflatex Ausarbeitung.tex
pdflatex Ausarbeitung.tex
```

See [Building PDFs](Building-PDFs.md) for complete guide.

### Why do I need to run LaTeX multiple times?

LaTeX requires multiple passes to resolve:
- Cross-references (`\ref`)
- Citations (`\cite`)
- Table of contents
- Bibliography

**Typical sequence**:
1. First pass: Generate `.aux` files
2. Biber: Process bibliography
3. Second pass: Incorporate citations
4. Third pass: Resolve cross-references

### What is latexmk and should I use it?

`latexmk` is a Perl script that automatically runs LaTeX and Biber the correct number of times. **Yes, you should use it** - it's the easiest method.

```bash
latexmk -pdf Ausarbeitung.tex
```

### How do I clean up build artifacts?

```bash
# Using latexmk
latexmk -c  # Keep PDF
latexmk -C  # Remove everything including PDF

# Using cleanup scripts
./cleanup/Remove_Junk_Linux.sh

# Manual
rm -f *.aux *.log *.out *.bbl *.blg *.bcf *.run.xml
```

### Where do I find the generated PDFs?

**In the repository** (PDFs are committed directly):
- `Ausarbeitung/Ausarbeitung.pdf` — 17-page written paper
- `Vortrag/Vortrag.pdf` — 68-page Beamer presentation (with pause overlays)
- `Vortrag/Vortrag-Druckversion.pdf` — 51-page print version (without pauses)

**After local builds**: In the same directory as the `.tex` file.

**CI/CD builds**: As GitHub Actions artifacts (available in the Actions tab).

### The build fails with "Package not found"

Install the missing package:

```bash
# Ubuntu/Debian
sudo apt-get install texlive-latex-extra

# macOS (most packages included in MacTeX)
brew install --cask mactex

# Windows MiKTeX (auto-installs on first use)
```

Or update the CI/CD workflow to include the package.

## Git and Version Control

### What branch should I work on?

- **Never commit directly to `main`**
- Create feature branches: `feature/my-feature`
- Submit pull requests for review

```bash
git checkout -b feature/my-changes
# Make changes
git push origin feature/my-changes
# Create PR on GitHub
```

### How do I update my fork?

```bash
# Add upstream remote (once)
git remote add upstream https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git

# Fetch and merge updates
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

### Should I commit build artifacts (PDFs, aux files)?

In **this project**, yes — build artifacts ARE committed to the repository. The `.gitignore` has LaTeX auxiliary file patterns listed but commented out. This is intentional for this project.

- ✅ **DO commit**: `.tex`, `.bib`, `.pdf`, `.aux`, `.bbl`, scripts, documentation
- ❌ **DON'T commit** (unless intentional): large binary files unrelated to the project

### What's the difference between the branches?

- **`main`**: Primary development branch
- **Feature branches**: Temporary branches for development (merged to main via PRs)
- **Template branch**: Preserved template (don't merge to main)

See [Project Structure](Project-Structure.md) for details.

## LaTeX Specific

### How do I add citations?

1. **Add entry to `.bib` file**:
   ```bibtex
   @article{smith2020,
     author = {Smith, John},
     title = {Article Title},
     journal = {Journal Name},
     year = {2020}
   }
   ```

2. **Cite in `.tex` file**:
   ```latex
   According to \cite{smith2020}, ...
   ```

3. **Rebuild**:
   ```bash
   latexmk -pdf Ausarbeitung.tex
   ```

### Citations aren't showing up

Ensure you're using Biber (this project uses `backend=biber`):

**In TeXstudio**:
- Options → Configure TeXstudio → Build
- Set "Default Bibliography Tool" to **Biber**

**Command line**:
```bash
pdflatex Ausarbeitung.tex
biber Ausarbeitung
pdflatex Ausarbeitung.tex
```

### How do I include German characters (ä, ö, ü)?

Ensure your preamble includes:

```latex
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[ngerman]{babel}
```

Save files with UTF-8 encoding.

### How do I include images?

```latex
\usepackage{graphicx}

\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\textwidth]{image.pdf}
  \caption{Description}
  \label{fig:mylabel}
\end{figure}
```

**Supported formats**: PDF, PNG, JPG (PDF preferred for vector graphics)

### What LaTeX packages are available?

Check the CI/CD workflow (`.github/workflows/build-and-publish-pdfs.yml`) for installed packages. Common packages:
- `graphicx`, `hyperref`, `amsmath`, `babel`, `biblatex`

If you need additional packages, add them to the workflow.

## CI/CD and Automation

### How long does the CI/CD build take?

Typically **2-5 minutes** depending on:
- Document complexity
- Number of packages needed
- GitHub Actions queue

### Where can I see build logs?

1. Go to [Actions tab](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions)
2. Click on the workflow run
3. Expand steps to view logs

### Why did the spell check fail?

Common reasons:
- Actual typos (fix them!)
- Technical terms not in dictionary (add to `cspell.json`)
- Proper nouns (add to `cspell.json` or use inline ignore)

**Fix by adding to dictionary**:
```json
{
  "words": [
    "newterm",
    "propernouns"
  ]
}
```

### Can I run CI checks locally?

Yes!

```bash
# Spell check
npx cspell "**/*.tex" "**/*.md"

# Build
latexmk -pdf Ausarbeitung/Ausarbeitung.tex

# LaTeX lint
lacheck Ausarbeitung/Ausarbeitung.tex
```

### Where can I find the PDFs directly?

The compiled PDFs are committed directly to the repository in the `main` branch:

```bash
# Clone the repo and find PDFs in:
Ausarbeitung/Ausarbeitung.pdf
Vortrag/Vortrag.pdf
Vortrag/Vortrag-Druckversion.pdf
```

## Contributing

### How can I contribute?

See the [Contributing Guidelines](Contributing.md) for detailed instructions.

Quick steps:
1. Fork the repository
2. Create a feature branch
3. Make changes and test locally
4. Submit a pull request

### Do I need to be a LaTeX expert?

No! Contributions welcome at all levels:
- **Documentation**: Fix typos, improve clarity
- **Content**: Add sections, examples
- **Code**: Improve scripts, workflows
- **Testing**: Report bugs, test on different platforms

### How do I report a bug?

1. Check [existing issues](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/issues)
2. Use the bug report template
3. Include:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details

### My PR failed CI checks, what now?

1. Review the failed check logs
2. Fix the issues locally
3. Commit and push the fixes
4. PR will update automatically

Common fixes:
- Spell check: Add words to dictionary
- Build errors: Fix LaTeX syntax
- Lint: Follow style guidelines

### How long until my PR is reviewed?

Varies depending on:
- Maintainer availability
- PR complexity
- Project activity

Typical timeframe: **1-7 days**

Be patient and feel free to ping if no response after a week.

## Still Have Questions?

- 📖 Check the [wiki documentation](Home.md)
- 🐛 Search [existing issues](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/issues)
- 💬 Create a new issue with the "question" label
- 📧 Contact the maintainers

---

[← Back to Wiki Home](Home.md)
