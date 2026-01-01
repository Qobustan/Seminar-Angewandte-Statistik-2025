# ==============================================================================
#
#          FILE: latexmkrc.pl
#
#   DESCRIPTION: Configuration file for latexmk build automation
#
#         USAGE: Place in project root or ~/.latexmkrc
#
# ==============================================================================

# Set LaTeX engine to pdflatex with error handling
$latex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';

# Set BibTeX processor
$bibtex = 'bibtex %O %S';

# Use PDF mode as default (1 = pdflatex, 4 = lualatex, 5 = xelatex)
$pdf_mode = 1;

# Prevent automatic deletion of .bbl files during cleanup
$cleanup_mode = 0;

# Maximum number of compilation runs to resolve references
$max_repeat = 5;

# Output directory (commented out by default)
# $out_dir = 'build';

# Continuous preview mode settings
$preview_continuous_mode = 0;

# PDF viewer settings (platform-specific)
# Uncomment and modify based on your system:
# $pdf_previewer = 'start evince';    # Linux
# $pdf_previewer = 'start open';      # macOS  
# $pdf_previewer = 'start';           # Windows
