# Small information (since usually people do not read forewords anyway...):
Please note that the names of the files are not the true names but placeholders because the stuff here is just archived and not maintained in any way.
You are solely responsible to look for the correct names if you are willing to use this code.
This readme may contain errors or may be incomplete as it is legacy and not maintained in any way...
The flags mentioned here are regularly not added to all of these files. However it is intended to serve as a guideline...

# Legacy LaTeX Code

You are currently in the legacy folder, which contains outdated LaTeX files from previous versions of the project. These files are no longer actively maintained but are preserved for reference, historical purposes, or for supporting legacy versions of the documentation.

## About the Legacy Code

This folder contains LaTeX files that were used in earlier versions of the project. The files may include:

- **Outdated `.tex` files**: These were the primary LaTeX documents in the past but are now superseded by newer versions.
- **Old `.bib` files**: These files manage references and citations, but may not match the current citation style or project format.
- **Deprecated style files (`.sty`)**: Custom LaTeX style files that are no longer in use but were once integral to the formatting.
- **Old figures and tables**: Images or data tables that were used in previous iterations of the project but are no longer part of the main documentation.

These files may not compile correctly with modern LaTeX distributions without modification, as they might rely on outdated packages or LaTeX syntax.

## Compilation Instructions

To compile the LaTeX files in this folder, follow the steps below. Please note that these files may not work well with modern LaTeX compilers without adjustments.

1. **Navigate to this folder (if you're not already here):**
    ```bash
    cd legacy
    ```

2. **Compile the LaTeX document:**
    ```bash
    pdflatex legacy-document.tex
    bibtex legacy-document
    pdflatex legacy-document.tex
    pdflatex legacy-document.tex
    ```

   Make sure that all related files (e.g., `.bib`, images, or style files) are available and properly linked in the LaTeX document.

> **Warning**: Some LaTeX packages used in these files may be deprecated or incompatible with modern LaTeX distributions. Check the compilation logs for missing dependencies or version mismatches.

## Known Issues

- **Bibliography Issues**: The `.bib` file in this folder is likely outdated and might need to be revised to match the current project's citation style.
- **Package Compatibility**: Some LaTeX packages used in these files may no longer be supported by current LaTeX distributions.
- **Broken References**: There might be issues with cross-references, figures, or tables that no longer exist or have been renamed.

## Important Notes

- **Deprecated Files**: These files are no longer in active development and may not be compatible with newer LaTeX setups. They are provided for historical reference only.
- **Outdated Formats**: Some LaTeX syntax and package versions in this folder are obsolete. If you plan to adapt or use these files, you may need to update them to ensure compatibility with modern LaTeX environments.
- **Compile Results**: The output from compiling these files might differ from the current project's output due to changes in formatting, styling, or content structure.

## Future Considerations

If you need to work with the legacy code, consider migrating relevant content to the current LaTeX setup. It's recommended to update any outdated packages or LaTeX constructs to ensure continued compatibility. If the legacy code is not needed for immediate work, it may be helpful to archive it to prevent confusion in the future.

## Available Scripts

### build-seminar.sh

A functional build script specifically designed for this repository. Unlike the original `build.sh`, this script properly builds the Ausarbeitung and Vortrag documents.

**Usage:**
```bash
./legacy/build-seminar.sh              # Build both documents
./legacy/build-seminar.sh -v -c        # Verbose output with cleanup
./legacy/build-seminar.sh -a           # Build only Ausarbeitung
./legacy/build-seminar.sh -p           # Build only Vortrag
./legacy/build-seminar.sh --help       # Show help
```

### debug.sh (Legacy)

Debug script for the original web application build. Not used for LaTeX compilation.
