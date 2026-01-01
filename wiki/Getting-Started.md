# Getting Started

This guide will help you get started with the Seminar: Angewandte Statistik 2025 project.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Git**: For cloning and version control
- **LaTeX Distribution**: TeX Live (Linux/Windows) or MacTeX (macOS)
- **LaTeX Editor** (optional but recommended): TeXstudio or your preferred editor

For detailed LaTeX installation instructions, see:
- [LaTeX Installation Guide (English)](../LaTeX-Install.md)
- [LaTeX Installation Guide (German)](../LaTeX-Install.de.md)

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git
cd Seminar-Angewandte-Statistik-2025
```

### 2. Explore the Structure

The repository is organized as follows:

- **`Ausarbeitung/`** - Written elaboration (main paper)
- **`Vortrag/`** - Presentation slides
- **`Besprechung/`** - Meeting notes and discussions
- **`scripts/`** - Build and maintenance scripts
- **`archive/`** - Historical documentation and branch snapshots

### 3. Build PDFs Locally

#### Option A: Using Scripts

```bash
# Build all PDFs
./scripts/generatePdf.sh
```

#### Option B: Using latexmk

```bash
# Build the elaboration
cd Ausarbeitung
latexmk -pdf Ausarbeitung.tex

# Build the presentation
cd ../Vortrag
latexmk -pdf Vortrag.tex
```

#### Option C: Using Docker

```bash
# Build using Docker
docker build -t latex-builder .
docker run --rm -v $(pwd):/workspace latex-builder
```

### 4. Make Your Changes

1. Create a new branch for your work:
   ```bash
   git checkout -b your-feature-branch
   ```

2. Edit the LaTeX files in `Ausarbeitung/` or `Vortrag/`

3. Build locally to verify your changes

4. Commit your changes:
   ```bash
   git add .
   git commit -m "Description of your changes"
   ```

5. Push your branch:
   ```bash
   git push origin your-feature-branch
   ```

6. Open a pull request on GitHub

### 5. Automated CI/CD

When you push to GitHub, the CI/CD workflows will automatically:

- ✅ Check BibTeX references
- ✅ Validate formatting
- ✅ Run spell-checking
- ✅ Build PDFs (on push to main)
- ✅ Publish PDFs to the `pdfs` branch

See [CI/CD Workflows](CI-CD-Workflows.md) for more details.

## Editor Configuration

### TeXstudio Setup

After installing TeXstudio, configure Biber as the bibliography backend:

**Options** → **Configure TeXstudio** → **Build** → **Default Bibliography Tool: Biber**

### Visual Studio Code

If using VS Code, consider installing:
- LaTeX Workshop extension
- Code Spell Checker extension

Configuration file: `.vscode/settings.json` (create if needed)

```json
{
  "latex-workshop.latex.autoBuild.run": "never",
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": ["-pdf", "-interaction=nonstopmode", "%DOC%"]
    }
  ]
}
```

## Next Steps

- Review the [Project Structure](Project-Structure.md) for detailed organization
- Read the [Contributing Guidelines](Contributing.md) before making changes
- Check out the [Building PDFs](Building-PDFs.md) guide for advanced build options
- Browse the [FAQ](FAQ.md) for common questions

## Getting Help

If you run into issues:

1. Check the [Troubleshooting Guide](Troubleshooting.md)
2. Review existing [GitHub Issues](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/issues)
3. Create a new issue using our templates

---

[← Back to Wiki Home](Home.md)
