# Building PDFs

This guide covers all methods for building PDF documents from the LaTeX sources in this repository.

## Table of Contents

- [Quick Build Methods](#quick-build-methods)
- [Local Building](#local-building)
- [Using Scripts](#using-scripts)
- [Using Docker](#using-docker)
- [CI/CD Automated Builds](#cicd-automated-builds)
- [Troubleshooting Builds](#troubleshooting-builds)

## Quick Build Methods

### Method 1: Project Script (Recommended)

```bash
./scripts/generatePdf.sh
```

This script handles the complete build process including multiple LaTeX passes and bibliography compilation.

### Method 2: latexmk (Most Reliable)

```bash
# Build elaboration
cd Ausarbeitung
latexmk -pdf Ausarbeitung.tex

# Build presentation
cd ../Vortrag
latexmk -pdf Vortrag.tex
```

### Method 3: Manual PDFLaTeX

```bash
cd Ausarbeitung
pdflatex Ausarbeitung.tex
biber Ausarbeitung
pdflatex Ausarbeitung.tex
pdflatex Ausarbeitung.tex
```

## Local Building

### Prerequisites

Ensure you have a complete LaTeX distribution installed:

- **Linux**: TeX Live
  ```bash
  sudo apt-get install texlive texlive-lang-german texlive-latex-extra biber
  ```

- **macOS**: MacTeX
  ```bash
  # Download from https://www.tug.org/mactex/
  # Or use Homebrew:
  brew install --cask mactex
  ```

- **Windows**: TeX Live or MiKTeX
  - Download from https://www.tug.org/texlive/
  - Or use MiKTeX: https://miktex.org/

For detailed installation instructions, see:
- [LaTeX Installation Guide (English)](../LaTeX-Install.md)
- [LaTeX Installation Guide (German)](../LaTeX-Install.de.md)

### Building the Elaboration (Ausarbeitung)

The elaboration is the main written document.

#### Using latexmk (Recommended)

```bash
cd Ausarbeitung
latexmk -pdf -interaction=nonstopmode Ausarbeitung.tex
```

**Benefits of latexmk**:
- Automatically runs LaTeX and BibTeX the correct number of times
- Detects and handles cross-references
- Cleans up auxiliary files with `-c` or `-C`

#### Manual Build Process

If you prefer manual control:

```bash
cd Ausarbeitung

# First pass: generate aux files
pdflatex -interaction=nonstopmode Ausarbeitung.tex

# Process bibliography
biber Ausarbeitung

# Second pass: incorporate bibliography
pdflatex -interaction=nonstopmode Ausarbeitung.tex

# Third pass: resolve all references
pdflatex -interaction=nonstopmode Ausarbeitung.tex
```

**Why multiple passes?**
- **Pass 1**: Creates `.aux` files with references
- **Biber**: Processes bibliography and creates `.bbl` file
- **Pass 2**: Incorporates bibliography citations
- **Pass 3**: Resolves any remaining cross-references

### Building the Presentation (Vortrag)

The presentation uses LaTeX Beamer.

#### Using latexmk

```bash
cd Vortrag
latexmk -pdf -interaction=nonstopmode Vortrag.tex
```

#### Manual Build Process

```bash
cd Vortrag
pdflatex -interaction=nonstopmode Vortrag.tex
biber Vortrag
pdflatex -interaction=nonstopmode Vortrag.tex
pdflatex -interaction=nonstopmode Vortrag.tex
```

### Cleaning Build Artifacts

#### Using latexmk

```bash
# Remove auxiliary files (keep PDF)
latexmk -c

# Remove all generated files (including PDF)
latexmk -C
```

#### Using Cleanup Scripts

```bash
# Linux/macOS
./cleanup/Remove_Junk_Linux.sh

# Windows
cleanup\Remove_Junk_Windows.bat
```

#### Manual Cleanup

```bash
# Remove common auxiliary files
rm -f *.aux *.log *.out *.toc *.bbl *.blg *.bcf *.run.xml *.synctex.gz *.nav *.snm
```

## Using Scripts

### generatePdf.sh

The project includes a comprehensive build script:

```bash
./scripts/generatePdf.sh
```

**Features**:
- Builds both Ausarbeitung and Vortrag
- Handles multiple LaTeX passes
- Processes bibliographies
- Provides detailed build logs
- Error handling and reporting

**Script Options** (if available):

```bash
# Build only elaboration
./scripts/generatePdf.sh ausarbeitung

# Build only presentation
./scripts/generatePdf.sh vortrag

# Clean build (remove artifacts first)
./scripts/generatePdf.sh clean
```

### Legacy Build Scripts

Located in `legacy/` directory:

```bash
# Legacy build script
./legacy/build.sh

# Legacy debug script
./legacy/debug.sh
```

## Using Docker

Build PDFs in a containerized environment for consistency.

### Building the Docker Image

```bash
docker build -t latex-seminar .
```

### Running the Build

```bash
# Build in Docker container
docker run --rm -v $(pwd):/workspace latex-seminar

# Interactive session
docker run -it --rm -v $(pwd):/workspace latex-seminar /bin/bash
```

**Docker Benefits**:
- ✅ Consistent build environment
- ✅ No local LaTeX installation required
- ✅ Isolated dependencies
- ✅ Reproducible builds

### Dockerfile Structure

The Dockerfile includes:
- Minimal TeX Live installation
- Required LaTeX packages
- Build automation scripts
- German language support

## CI/CD Automated Builds

### GitHub Actions Workflow

PDFs are automatically built by GitHub Actions on every push to `main`.

**Workflow**: `.github/workflows/build-and-publish-pdfs.yml`

#### Trigger Conditions

- Push to `main` branch
- Manual workflow dispatch
- Pull requests (build only, no publish)

#### Build Process

1. **Setup**: Install minimal TeX Live
2. **Build**: Compile both documents with latexmk
3. **Collect**: Gather generated PDFs
4. **Publish**: Push PDFs to `pdfs` branch

#### Accessing Built PDFs

```bash
# Clone the pdfs branch
git clone -b pdfs https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git pdfs
cd pdfs
```

Or download directly from GitHub:
- Navigate to the `pdfs` branch on GitHub
- Download the desired PDF files

### Viewing Build Logs

Check the Actions tab on GitHub:

1. Go to: https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/actions
2. Click on "Build all LaTeX projects" workflow
3. Select a specific run to view logs

See [CI/CD Workflows](CI-CD-Workflows.md) for more details.

## Troubleshooting Builds

### Common Issues

#### Issue: "Package not found"

**Solution**: Install missing LaTeX packages

```bash
# Ubuntu/Debian
sudo apt-get install texlive-latex-extra texlive-science

# macOS (with MacTeX)
# Most packages are included by default

# Windows (MiKTeX)
# Packages are auto-installed on first use
```

#### Issue: "biber command not found"

**Solution**: Install Biber

```bash
# Ubuntu/Debian
sudo apt-get install biber

# macOS
brew install biber

# Windows
# Included with TeX Live/MiKTeX
```

#### Issue: "Undefined references"

**Solution**: Run LaTeX multiple times

```bash
# Use latexmk for automatic handling
latexmk -pdf Ausarbeitung.tex

# Or manually run 3 times
pdflatex Ausarbeitung.tex
biber Ausarbeitung
pdflatex Ausarbeitung.tex
pdflatex Ausarbeitung.tex
```

#### Issue: "Bibliography not showing"

**Solution**: Ensure Biber is configured correctly

In TeXstudio:
- **Options** → **Configure TeXstudio** → **Build**
- Set **Default Bibliography Tool** to **Biber** (not BibTeX)

#### Issue: "German characters not displaying"

**Solution**: Check encoding and packages

Ensure `header.tex` includes:

```latex
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[ngerman]{babel}
```

### Build Logs

Check LaTeX log files for detailed error information:

```bash
# View build log
less Ausarbeitung/Ausarbeitung.log

# Search for errors
grep -i error Ausarbeitung/Ausarbeitung.log

# Check bibliography log
less Ausarbeitung/Ausarbeitung.blg
```

### Performance Tips

#### Faster Builds

1. **Use draft mode** during editing:
   ```latex
   \documentclass[draft]{article}
   ```

2. **Disable graphics** temporarily:
   ```latex
   \usepackage[demo]{graphicx}
   ```

3. **Use incremental builds**:
   ```bash
   latexmk -pvc -pdf Ausarbeitung.tex  # Continuous preview
   ```

### Verification

After building, verify the PDF:

```bash
# Check PDF was created
ls -lh Ausarbeitung/Ausarbeitung.pdf

# Open PDF
# Linux
xdg-open Ausarbeitung/Ausarbeitung.pdf

# macOS
open Ausarbeitung/Ausarbeitung.pdf

# Windows
start Ausarbeitung/Ausarbeitung.pdf
```

## Advanced Build Options

### Custom latexmk Configuration

Create `.latexmkrc` in the project root:

```perl
$pdf_mode = 1;  # Generate PDF using pdflatex
$bibtex_use = 2;  # Use biber for bibliography
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
```

### Parallel Builds

Build both documents simultaneously:

```bash
# Using GNU Parallel (if installed)
parallel latexmk -pdf ::: Ausarbeitung/Ausarbeitung.tex Vortrag/Vortrag.tex

# Using background jobs
(cd Ausarbeitung && latexmk -pdf Ausarbeitung.tex) &
(cd Vortrag && latexmk -pdf Vortrag.tex) &
wait
```

### Word Count

Count words in LaTeX documents:

```bash
# Using texcount
texcount Ausarbeitung/Ausarbeitung.tex

# Using the project script
./task_skripts/perl/texcount.pl Ausarbeitung/Ausarbeitung.tex
```

## Next Steps

- Learn about [CI/CD Workflows](CI-CD-Workflows.md)
- Review [Project Structure](Project-Structure.md)
- Check [Troubleshooting](Troubleshooting.md) for more help

---

[← Back to Wiki Home](Home.md)
