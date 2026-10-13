---
name: write-adr
description: Legt einen neuen Architecture Decision Record in docs/decisions an. Verwenden, wenn eine technische Entscheidung getroffen oder geändert wird (Tool-Wahl, Struktur, Plattform).
---

<!--
  Gemeinsam für alle Flavors. Ordnername = "name" im Frontmatter.
  "description" entscheidet, wann der Agent den Skill lädt.
-->

# ADR anlegen

1. Nächste freie Nummer ermitteln: höchste `NNNN` in `docs/decisions/` + 1.
2. `docs/decisions/0000-template.md` kopieren als `NNNN-<kurzer-titel-mit-bindestrichen>.md`.
3. Abschnitte ausfüllen. Bei **Alternativen** mindestens eine echte Alternative mit Begründung.
4. Ersetzt der ADR einen älteren: beim alten nur den Status auf `Ersetzt durch NNNN` ändern.
5. In der README-Tree-View ist `docs/decisions/` als Ordner aufgeführt – keine Einzeldatei ergänzen.
