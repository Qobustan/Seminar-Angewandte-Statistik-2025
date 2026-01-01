# Contributing Guidelines

Thank you for your interest in contributing to the Seminar: Angewandte Statistik 2025 project! This guide will help you get started.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [LaTeX Style Guide](#latex-style-guide)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Reporting Issues](#reporting-issues)

## Code of Conduct

### Our Standards

- **Be respectful**: Treat everyone with respect and kindness
- **Be collaborative**: Work together constructively
- **Be professional**: Keep discussions focused and productive
- **Be inclusive**: Welcome diverse perspectives and backgrounds

### Unacceptable Behavior

- Harassment or discriminatory language
- Personal attacks or trolling
- Publishing others' private information
- Other unprofessional conduct

## Getting Started

### 1. Fork and Clone

```bash
# Fork the repository on GitHub, then:
git clone https://github.com/YOUR-USERNAME/Seminar-Angewandte-Statistik-2025.git
cd Seminar-Angewandte-Statistik-2025
```

### 2. Set Up Upstream

```bash
git remote add upstream https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git
git fetch upstream
```

### 3. Install Dependencies

Follow the [Getting Started Guide](Getting-Started.md) to install:
- LaTeX distribution (TeX Live or MacTeX)
- LaTeX editor (TeXstudio or VS Code)
- Git

### 4. Verify Setup

```bash
# Test that you can build locally
cd Ausarbeitung
latexmk -pdf Ausarbeitung.tex
```

## How to Contribute

### Types of Contributions

We welcome various types of contributions:

#### 📝 Documentation
- Improve existing documentation
- Add examples and tutorials
- Fix typos and grammar
- Translate documentation

#### 🐛 Bug Fixes
- Fix LaTeX compilation errors
- Correct BibTeX issues
- Resolve CI/CD problems
- Fix broken links

#### ✨ Features
- Add new sections to documents
- Improve document structure
- Enhance build scripts
- Add new workflows

#### 🧪 Testing
- Report bugs
- Test on different platforms
- Validate PDF outputs
- Review pull requests

## Development Workflow

### 1. Create a Branch

```bash
# Create a feature branch
git checkout -b feature/your-feature-name

# Or a bugfix branch
git checkout -b bugfix/issue-description
```

**Branch naming conventions**:
- `feature/` - New features or enhancements
- `bugfix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring
- `test/` - Test additions or modifications

### 2. Make Your Changes

Edit the relevant files:

```bash
# For elaboration changes
vim Ausarbeitung/Ausarbeitung.tex

# For presentation changes
vim Vortrag/Vortrag.tex

# For documentation
vim README.md
```

### 3. Test Your Changes

**Build locally**:
```bash
# Test elaboration
cd Ausarbeitung
latexmk -pdf Ausarbeitung.tex

# Test presentation
cd ../Vortrag
latexmk -pdf Vortrag.tex
```

**Run quality checks**:
```bash
# Spell check
npx cspell "**/*.tex" "**/*.md"

# LaTeX lint
lacheck Ausarbeitung/Ausarbeitung.tex
```

### 4. Commit Your Changes

```bash
git add .
git commit -m "Brief description of changes"
```

See [Commit Guidelines](#commit-guidelines) for commit message conventions.

### 5. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 6. Create Pull Request

1. Go to your fork on GitHub
2. Click "New Pull Request"
3. Select your branch
4. Fill in the PR template
5. Submit for review

## LaTeX Style Guide

### General Principles

1. **Consistency**: Follow existing style in the document
2. **Readability**: Write clear, well-structured LaTeX
3. **Comments**: Explain complex structures
4. **Modularity**: Use separate files for large sections

### Formatting

#### Indentation

Use **2 spaces** for indentation:

```latex
\begin{document}
  \section{Title}
    \subsection{Subtitle}
      Content here.
    \end{subsection}
  \end{section}
\end{document}
```

#### Line Length

Keep lines under **80-100 characters** when practical:

```latex
% Good: Reasonable line length
Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
sed do eiusmod tempor incididunt ut labore.

% Avoid: Very long lines
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
```

#### Whitespace

Use blank lines to separate logical blocks:

```latex
\section{Introduction}

This is the introduction paragraph.

\subsection{Background}

Background information here.
```

### Commands and Environments

#### Brackets

Use `{}` consistently:

```latex
% Good
\textbf{bold text}
\cite{reference2020}

% Avoid (even though it works)
\textbf bold text
```

#### Optional Arguments

Place optional arguments on the same line:

```latex
% Good
\includegraphics[width=0.8\textwidth]{figure.pdf}

% Avoid
\includegraphics
  [width=0.8\textwidth]
  {figure.pdf}
```

### BibTeX Style

#### Entry Format

```bibtex
@article{author2020title,
  author  = {Author, First and Author, Second},
  title   = {The Title of the Article},
  journal = {Journal Name},
  year    = {2020},
  volume  = {10},
  number  = {2},
  pages   = {123--145},
  doi     = {10.1234/journal.2020.001}
}
```

#### Key Naming

Use format: `firstauthor[year][shortitle]`

```bibtex
% Good
smith2020machine
jones2019deep

% Avoid
ref1
paper2
smithetal
```

### Comments

#### Section Comments

```latex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section: Introduction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
```

#### Inline Comments

```latex
% TODO: Add more details here
\section{Introduction}

% FIXME: Check citation format
\cite{reference}

% NOTE: This requires the hyperref package
\href{http://example.com}{Link}
```

### German Language

For German text, use proper babel settings:

```latex
\usepackage[ngerman]{babel}

% Use German quotes
\glqq German text\grqq{}

% Or use csquotes
\usepackage[german=quotes]{csquotes}
\enquote{German text}
```

## Commit Guidelines

### Commit Message Format

```
<type>: <subject>

<body>

<footer>
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Formatting, missing semicolons, etc.
- **refactor**: Code refactoring
- **test**: Adding tests
- **chore**: Maintenance tasks

### Examples

```bash
# Feature
git commit -m "feat: Add section on statistical methods"

# Bug fix
git commit -m "fix: Correct BibTeX citation format"

# Documentation
git commit -m "docs: Update installation instructions"

# Multi-line with body
git commit -m "feat: Add regression analysis section

- Add mathematical formulas
- Include example calculations
- Add references to literature"
```

### Best Practices

1. **Use imperative mood**: "Add feature" not "Added feature"
2. **Be concise**: Keep subject line under 50 characters
3. **Be specific**: Clearly describe what changed
4. **Reference issues**: Include issue numbers when applicable

```bash
# Good
git commit -m "fix: Resolve undefined reference error (#42)"

# Good
git commit -m "docs: Add contributing guidelines"

# Avoid
git commit -m "fixes"
git commit -m "update"
git commit -m "changes to files"
```

## Pull Request Process

### Before Submitting

- [ ] Build succeeds locally
- [ ] Spell check passes
- [ ] No LaTeX errors or warnings
- [ ] Bibliography compiles correctly
- [ ] Changes are documented
- [ ] Commit messages follow guidelines

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Testing
How were these changes tested?

## Screenshots (if applicable)
Include before/after images

## Checklist
- [ ] Code builds successfully
- [ ] Tests pass
- [ ] Documentation updated
```

### Review Process

1. **Automated checks**: CI/CD workflows run automatically
2. **Code review**: Maintainers review your changes
3. **Feedback**: Address any requested changes
4. **Approval**: Once approved, PR will be merged

### Addressing Feedback

```bash
# Make requested changes
git add .
git commit -m "Address review feedback"
git push origin feature/your-feature-name
```

The PR will update automatically.

## Reporting Issues

### Before Creating an Issue

1. **Search existing issues**: Check if already reported
2. **Check documentation**: Review wiki and README
3. **Test locally**: Verify it's reproducible

### Issue Templates

Use the appropriate template:
- **Bug Report**: For reporting bugs
- **Feature Request**: For suggesting features
- **Custom**: For other issues

### Bug Report Template

```markdown
**Describe the bug**
Clear description of the bug

**To Reproduce**
1. Go to '...'
2. Run '...'
3. See error

**Expected behavior**
What should happen

**Environment**
- OS: [e.g., Ubuntu 22.04]
- TeX distribution: [e.g., TeX Live 2023]
- LaTeX editor: [e.g., TeXstudio]

**Additional context**
Any other relevant information
```

### Feature Request Template

```markdown
**Is your feature request related to a problem?**
Description of the problem

**Describe the solution you'd like**
Clear description of desired feature

**Describe alternatives you've considered**
Other solutions you've thought about

**Additional context**
Any other relevant information
```

## Questions?

If you have questions about contributing:

1. Check the [FAQ](FAQ.md)
2. Review existing [issues and discussions](https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025/issues)
3. Create a new issue with the "question" label

## Recognition

Contributors are recognized in:
- Git commit history
- Release notes
- Project documentation

Thank you for contributing! 🎉

---

[← Back to Wiki Home](Home.md)
