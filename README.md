# Seminar-Angewandte-Statistik-2025

```markdown
# Proyecto LaTeX: Seminar script + Beamer

Este repositorio contiene dos documentos LaTeX:

- `seminar_skript.tex` — documento principal (script)
- `seminar_presentation.tex` — presentación en Beamer

CI / GitHub Actions:
- En cada push / PR (y una ejecución diaria opcional) GitHub Actions:
  - instala TeX básico (latexmk, biber y paquetes comunes),
  - ejecuta Gradle (tarea `assemble`) para compilar ambos `.tex`,
  - sube los PDFs compilados como artifacts.

Compilar localmente:
- Instala TeX Live o TinyTeX y `latexmk`.
- Instala Java (JDK 11+).
- Genera o añade el Gradle Wrapper (recomendado).
- Ejecuta:
  ```bash
  ./gradlew assemble
  ```
Salida:
- PDFs generados en `build/`:
  - `build/seminar_skript.pdf`
  - `build/seminar_presentation.pdf`

Notas:
- Si prefieres `pdflatex` o `lualatex`, cambia la opción `-xelatex` en `build.gradle`.
- Puedes añadir publicación automática a GitHub Pages o Releases si lo deseas.
```
