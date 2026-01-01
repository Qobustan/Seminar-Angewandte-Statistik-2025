# FILE: latexxmkrc.pl
# DESCRIPTION: Konfigurationsdatei für latexmk - steuert das Build-Verhalten
#              von LaTeX-Dokumenten
# NOTE: Dies ist keine ausführbare Datei, sondern eine Konfiguration

# =============================================================================
# LaTeX-Engine Konfiguration
# =============================================================================

# Setze die LaTeX-Engine auf pdflatex mit hilfreichen Optionen:
# -interaction=nonstopmode : Stoppt nicht bei Fehlern (für automatisierte Builds)
# -file-line-error         : Gibt Fehler im Format "datei:zeile: fehler" aus
$latex = 'pdflatex -interaction=nonstopmode -file-line-error %O %S';

# Alternativ: Verwende pdflatex explizit (gleich wie $latex in diesem Fall)
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error %O %S';

# =============================================================================
# Bibliographie-Konfiguration
# =============================================================================

# Setze den BibTeX-Editor (falls Bibliographien verwendet werden)
$bibtex = 'bibtex %O %S';

# =============================================================================
# PDF-Modus und Ausgabe
# =============================================================================

# Verwende PDF-Ansicht als Standard (1 = PDF-Modus aktiviert)
$pdf_mode = 1;

# =============================================================================
# SyncTeX-Konfiguration (für Editor-Integration)
# =============================================================================

# Aktiviere SyncTeX für bessere Editor-Integration
# SyncTeX ermöglicht Springen zwischen PDF und Quellcode
$synctex = 1;

# =============================================================================
# Aufräum-Verhalten
# =============================================================================

# Verhindere, dass latexmk automatisch .bbl-Dateien löscht
# Dies ist nützlich, um generierte Bibliographie-Dateien zu behalten
$cleanup_mode = 0;

# =============================================================================
# Kompilierungs-Wiederholungen
# =============================================================================

# Führe die Kompilierung mehrmals aus, um alle Referenzen zu aktualisieren
# Dies stellt sicher, dass Querverweise, Inhaltsverzeichnis, etc. korrekt sind
$max_repeat = 5;

# =============================================================================
# PDF-Viewer-Konfiguration (Beispiele, auskommentiert)
# =============================================================================

# Beispiel für Linux mit evince:
# $pdf_previewer = 'evince %O %S';

# Beispiel für macOS mit Preview:
# $pdf_previewer = 'open -a Preview %O %S';

# Beispiel für Windows mit SumatraPDF:
# $pdf_previewer = 'start SumatraPDF %O %S';

# Beispiel für zathura (leichtgewichtiger PDF-Viewer):
# $pdf_previewer = 'zathura %O %S';

# =============================================================================
# Erweiterte Optionen (Beispiele, auskommentiert)
# =============================================================================

# Automatische Aktualisierung des PDF-Viewers bei Änderungen:
# $preview_continuous_mode = 1;

# Verwende XeLaTeX anstelle von pdfLaTeX (für Unicode-Unterstützung):
# $pdf_mode = 5;
# $pdflatex = 'xelatex -interaction=nonstopmode -file-line-error %O %S';

# Verwende LuaLaTeX anstelle von pdfLaTeX:
# $pdf_mode = 4;
# $pdflatex = 'lualatex -interaction=nonstopmode -file-line-error %O %S';
