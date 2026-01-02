# Security Policy

## Scope and Purpose

This security policy applies to the **Seminar: Angewandte Statistik 2025** repository, an academic LaTeX project repository. This document outlines our approach to security, supported versions, dependency management, and vulnerability reporting procedures.

## Project Context

This repository contains:
- LaTeX source files for academic documents (Ausarbeitung, Vortrag)
- Build scripts and utilities
- CI/CD workflows using GitHub Actions
- Documentation and wiki content

As an academic document repository, security considerations focus primarily on:
- Supply chain security (GitHub Actions, dependencies)
- Build integrity and reproducibility
- Safe handling of user contributions
- Protection of repository infrastructure

## Supported Versions

This repository follows a continuous development model on the `main` branch. Security updates and patches are applied to:

| Branch/Version | Status              | Notes                           |
| -------------- | ------------------- | ------------------------------- |
| `main` branch  | :white_check_mark: | Actively maintained             |
| Feature branches | :warning:         | Temporary; merged or deleted    |
| Archived branches | :x:              | Historical; not maintained      |

## Security Considerations

### 1. LaTeX and Build Security

**Risk:** Malicious LaTeX code can potentially execute arbitrary commands.

**Mitigations:**
- All LaTeX builds run in isolated CI/CD environments (GitHub Actions runners)
- Docker builds use containerization for additional isolation
- Review all external LaTeX packages and dependencies before inclusion
- Avoid using `\write18` or shell escape features unless absolutely necessary
- All CI builds run with `-interaction=nonstopmode` to prevent interactive prompts

### 2. GitHub Actions and CI/CD Security

**Risk:** Compromised GitHub Actions or workflow configurations could lead to supply chain attacks.

**Mitigations:**
- **Dependabot** is configured to automatically update GitHub Actions weekly
- GitHub Actions should be pinned to specific versions, preferably commit SHAs for enhanced security
- Workflow artifacts are retained for 90 days with appropriate access controls
- No secrets or credentials are stored in repository code
- Limited use of third-party actions; prefer GitHub-maintained actions

**Best Practices:**
```yaml
# Good: Pinned to commit SHA
- uses: actions/checkout@8e5e7e5ab8b370d6c329ec480221332ada57f0ab # v3.5.2

# Acceptable: Pinned to version tag
- uses: actions/checkout@v3

# Avoid: Unpinned (tracks latest, potentially unstable)
- uses: actions/checkout@main
```

### 3. Dependency Management

**Current Dependencies:**
- TeX Live (LaTeX distribution)
- GitHub Actions workflows
- Docker base images
- Build tools (latexmk, bibtex, pdflatex)

**Security Measures:**
- Dependabot monitors GitHub Actions for updates
- Docker images use official TeX Live base images
- All dependencies are specified explicitly in workflows and Dockerfiles
- Regular review of dependency updates through Dependabot PRs

### 4. Code Review and Quality Checks

All contributions undergo automated quality checks:
- **chktex** - LaTeX linting
- **cspell** - Spell checking
- **Format checks** - Code formatting validation
- **bibcheck** - Bibliography validation

These checks help prevent the introduction of malformed or potentially problematic code.

### 5. Access Control

- Repository maintainers have write access
- Contributors work through pull requests
- Branch protection rules enforce review requirements for the `main` branch
- GitHub Actions secrets are scoped appropriately

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability in this repository, please report it responsibly.

### How to Report

**For security issues, please do NOT create a public GitHub issue.**

Instead, use one of the following methods:

1. **GitHub Security Advisories (Preferred)**
   - Navigate to the repository's "Security" tab
   - Click "Report a vulnerability"
   - Fill out the security advisory form
   - This creates a private security advisory visible only to maintainers

2. **Direct Contact**
   - Email the repository owner directly (see repository profile)
   - Include detailed information about the vulnerability

### What to Include

When reporting a vulnerability, please provide:

- **Description:** Clear description of the vulnerability
- **Impact:** Potential impact and affected components
- **Reproduction:** Step-by-step instructions to reproduce the issue
- **Affected versions:** Which branches or workflow files are affected
- **Mitigation:** Any suggested fixes or workarounds (optional)
- **Credit:** How you would like to be credited (if applicable)

### Response Timeline

- **Initial Response:** Within 72 hours of report
- **Status Updates:** Weekly updates on investigation progress
- **Resolution:** Varies based on severity and complexity
  - Critical: 7 days
  - High: 14 days
  - Medium: 30 days
  - Low: 60 days

### What to Expect

1. **Acknowledgment:** We will acknowledge receipt of your report
2. **Investigation:** We will investigate and validate the vulnerability
3. **Fix Development:** If confirmed, we will develop and test a fix
4. **Disclosure:** We will coordinate disclosure timing with you
5. **Credit:** If desired, we will credit you in the security advisory

### Out of Scope

The following are generally outside the scope of this security policy:

- Issues with third-party LaTeX packages (report to package maintainers)
- Problems with local LaTeX installations (not repository-specific)
- Vulnerabilities in GitHub's infrastructure (report to GitHub)
- Issues with Docker, TeX Live, or other external tools (report upstream)

## Security Best Practices for Contributors

### When Contributing Code

1. **Review LaTeX Packages:** Only use well-established, maintained LaTeX packages
2. **Avoid Shell Commands:** Do not use `\write18` or shell escape features
3. **No Hardcoded Secrets:** Never commit passwords, tokens, or credentials
4. **Validate Inputs:** If scripts accept user input, validate and sanitize it
5. **Pin Dependencies:** When adding GitHub Actions, pin to specific versions
6. **Test Locally:** Build and test changes locally before submitting PRs

### When Adding GitHub Actions

1. **Use Official Actions:** Prefer actions from GitHub or trusted organizations
2. **Pin Versions:** Use commit SHA or version tags, not branch names
3. **Review Permissions:** Minimize required permissions in workflows
4. **Audit Third-Party Actions:** Review the source code of third-party actions
5. **Avoid Secrets in Logs:** Never log or echo sensitive information

### When Building Locally

1. **Use Docker:** For isolation, build PDFs using the provided Docker configuration
2. **Review Changes:** Check `git diff` before committing to avoid accidental inclusions
3. **Clean Build Artifacts:** Use cleanup scripts to remove temporary files
4. **Update Regularly:** Keep local tools and packages updated

## Security Updates and Announcements

Security updates will be announced through:

1. **GitHub Security Advisories** - For confirmed vulnerabilities
2. **Release Notes** - For security-related changes
3. **Pull Request Descriptions** - For dependency updates
4. **Commit Messages** - Tagged with `[security]` when relevant

## Additional Resources

- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [Dependabot Documentation](https://docs.github.com/en/code-security/dependabot)
- [LaTeX Security Considerations](https://www.tug.org/TUGboat/tb40-1/tb124gregorio-security.pdf)
- [Repository README](README.md)
- [Contributing Guidelines](README.md#contributing)
- [Disclaimer](DISCLAIMER.txt)

## Contact

For security-related questions or concerns that do not constitute vulnerabilities, you may:
- Open a GitHub Discussion
- Contact the repository maintainers through GitHub
- Refer to the repository's contribution guidelines

---

**Last Updated:** January 2026  
**Version:** 1.0

This security policy is subject to updates as the project evolves and new security considerations emerge.
