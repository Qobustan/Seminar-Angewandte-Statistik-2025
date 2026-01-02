# Contributing to Seminar: Angewandte Statistik 2025

Thank you for your interest in contributing to this project! This document provides guidelines and information for contributors.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [LaTeX Conventions](#latex-conventions)
- [Quality Checks](#quality-checks)
- [Pull Request Process](#pull-request-process)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Code of Conduct](#code-of-conduct)

## Getting Started

### Prerequisites

Before contributing, ensure you have the following installed:

- **TeX Live** (or MiKTeX on Windows) - LaTeX distribution
  - `pdflatex` - PDF generation
  - `bibtex` or `biber` - Bibliography management
  - `latexmk` - Automated LaTeX building (recommended)
- **Git** - Version control
- **chktex** - LaTeX linter (optional, used in CI)
- **cspell** - Spell checker (optional, used in CI)

For detailed installation instructions, see:
- [LaTeX Installation Guide (English)](latex_install/LaTeX-Install.md)
- [LaTeX Installation Guide (German)](latex_install/LaTeX-Install.de.md)

### Setting Up Your Development Environment

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Seminar-Angewandte-Statistik-2025.git
   cd Seminar-Angewandte-Statistik-2025
   ```
3. Add the upstream repository as a remote:
   ```bash
   git remote add upstream https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git
   ```
4. Verify your LaTeX installation:
   ```bash
   pdflatex --version
   bibtex --version
   latexmk --version
   ```

## Development Workflow

### Creating a Feature Branch

1. Ensure your main branch is up to date:
   ```bash
   git checkout main
   git pull upstream main
   ```
2. Create a new feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

### Making Changes

1. Make your changes to the LaTeX files
2. Test locally by building the PDFs:
   ```bash
   # Using the provided script
   ./scripts/generatePdf.sh
   
   # Or using latexmk directly
   cd Ausarbeitung
   latexmk -pdf Ausarbeitung.tex
   ```
3. Clean up temporary files:
   ```bash
   ./cleanup/Remove_Junk_Linux.sh  # On Linux/macOS
   ./cleanup/Remove_Junk_Windows.bat  # On Windows
   ```

### Testing Your Changes

Before submitting your changes, please:

1. **Build both PDFs** to ensure they compile successfully
2. **Check for LaTeX errors** in the log files
3. **Verify the output** - open and review the generated PDFs
4. **Run spell check** (if you have cspell installed):
   ```bash
   npm install -g cspell
   cspell "**/*.tex" "**/*.md" --config ./cspell.json
   ```
5. **Run LaTeX linter** (if you have chktex installed):
   ```bash
   find . -name "*.tex" -exec chktex -q -n1 -I0 {} +
   ```

## LaTeX Conventions

Please follow these conventions when contributing LaTeX code:

### General Style

- Use consistent indentation (tabs for LaTeX, as defined in `.editorconfig`)
- Keep line length reasonable (< 120 characters where possible)
- Use semantic LaTeX commands (e.g., `\emph{}` instead of `\textit{}`)
- Comment complex LaTeX macros or custom commands
- Use German language for content (`ngerman` babel package)

### File Organization

- **`Ausarbeitung/`** - Written elaboration
  - `Ausarbeitung.tex` - Main document
  - `header.tex` - Preamble and package configuration
  - `Ausarbeitung.bib` - Bibliography
- **`Vortrag/`** - Beamer presentation
  - `Vortrag.tex` - Main presentation
  - `header.tex` - Preamble and theme configuration
  - `Vortrag.bib` - Bibliography

### LaTeX Best Practices

1. **Packages**: Add new packages to `header.tex`, not in the main document
2. **Bibliography**: Use BibTeX format, maintain alphabetical order
3. **Cross-references**: Use `\label{}` and `\ref{}` consistently
4. **Figures**: Place figures in appropriate directories, use meaningful filenames
5. **Math**: Use `\[...\]` for display math, `$...$` for inline math
6. **Quotation**: Use `\enquote{}` from csquotes package for proper German quotation marks

### File Naming

- Use descriptive names for new files
- Follow existing naming conventions
- Use lowercase with hyphens for multi-word names (e.g., `bibliography-style.tex`)

## Quality Checks

The repository uses automated quality checks that run on every push and pull request:

### LaTeX Linting (chktex)

Checks for common LaTeX errors and style issues. Common issues include:
- Missing or incorrect spacing
- Inconsistent quotation marks
- Improper use of commands

### Spell Checking (cspell)

Checks spelling in LaTeX, Markdown, and text files. Custom dictionary is in `cspell.json`.

To add new words to the dictionary:
1. Edit `cspell.json`
2. Add words to the `words` array in alphabetical order
3. Commit the change with your contribution

### Bibliography Check

Verifies that `.bib` files don't contain duplicate entries.

### Format Check

Validates code formatting consistency (manual workflow dispatch only).

## Pull Request Process

### Before Submitting

1. Ensure all tests pass locally
2. Update documentation if you've made changes that affect it
3. Clean up any debug code or temporary files
4. Review your own changes using `git diff`

### Submitting a Pull Request

1. Push your changes to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
2. Go to the GitHub repository and create a Pull Request
3. Fill out the PR template with:
   - **Title**: Clear, concise description of the change
   - **Description**: What changed and why
   - **Testing**: How you tested the changes
   - **Related Issues**: Link to any related issues

### PR Review Process

- A maintainer will review your PR
- Address any feedback or requested changes
- Once approved, your PR will be merged
- Your contribution will be acknowledged in the project

## Commit Message Guidelines

Write clear, descriptive commit messages:

### Format

```
<type>: <short summary>

<optional detailed description>

<optional footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting, missing semicolons, etc. (no code change)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

### Examples

```
feat: add kernel density estimation section to Ausarbeitung

- Added mathematical derivation
- Included practical examples
- Added references to Rosenblatt (1956)

docs: update README with Docker build instructions

fix: correct bibtex citation format in bibliography
```

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the project and community
- Show empathy towards other contributors

### Unacceptable Behavior

- Harassment or discriminatory language
- Personal attacks or insults
- Publishing others' private information
- Other conduct inappropriate in a professional setting

### Reporting

If you experience or witness unacceptable behavior, please contact the repository maintainers through GitHub.

## Questions?

If you have questions about contributing:

1. Check the [FAQ in the Wiki](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki/FAQ)
2. Create an issue with the `question` label

## Additional Resources

- [Repository README](README.md)
- [Project Wiki](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/wiki)
- [Security Policy](SECURITY.md)
- [LaTeX Installation Guides](latex_install/)

---

Thank you for contributing to Seminar: Angewandte Statistik 2025! 🎓
