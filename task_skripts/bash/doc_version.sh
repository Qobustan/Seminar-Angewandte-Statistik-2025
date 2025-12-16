
#### 4.3 **Versionskontrolle der Dokumentation**

Wenn du mit Git arbeitest, kannst du ein Skript erstellen, um regelmäßig alle Änderungen an der Dokumentation zu committen und zu pushen. Ein solches Skript könnte auch automatisch die Änderungen an den LaTeX-Dateien und an den Bildern verfolgen.

**Beispiel: Git-Push-Skript**

```bash
#!/bin/bash

# Skript zum Committen und Pushen der Änderungen im LaTeX-Projekt

echo "Führe Git-Commit aus..."

# Alle Änderungen zum Commit hinzufügen
git add .

# Commit mit einer Nachricht
git commit -m "Aktualisierte Dokumentation und LaTeX-Dateien"

# Änderungen zum Git-Remote-Server pushen
git push origin main

echo "Änderungen wurden erfolgreich gepusht!"
