# 0003: Kein readOnlyRootFilesystem für das httpd-Beispiel

- **Status:** Akzeptiert
- **Datum:** 2026-10-13

## Kontext
`readOnlyRootFilesystem: true` ist Best Practice. Das Image `ubi9/httpd-24` passt beim Start seine
Konfiguration im Container an und braucht dafür Schreibzugriff.

## Entscheidung
Für diesen Container bleibt das Root-Dateisystem beschreibbar. Die Ausnahme ist am Deployment per
`ignore-check.kube-linter.io/no-read-only-root-fs` dokumentiert.

## Alternativen
- **emptyDir-Volumes für alle Schreibpfade:** fragil, hängt von Image-Interna ab.
- **Eigenes Image mit fertiger Konfiguration:** sinnvoll für echte Anwendungen.

## Konsequenzen
- Eigene Anwendungsimages sollen read-only lauffähig sein; dann Annotation und ADR entfernen.
