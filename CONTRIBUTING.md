<!--
  TEMPLATE: Gemeinsam für alle Flavors (wird in den Flavor-Branches nicht
  geändert). Wird über opencode.json auch dem Agent mitgegeben.
-->

# Mitwirken

## Workflow
1. Branch von `main` erstellen: `feat/<kurz>`, `fix/<kurz>`, `docs/<kurz>`, `chore/<kurz>`
2. Kleine, in sich abgeschlossene Commits.
3. `make check` lokal ausführen (bzw. `pre-commit run --all-files`).
4. Merge Request / Pull Request gegen `main`.

## Commit-Messages
[Conventional Commits](https://www.conventionalcommits.org/):
```
feat: Healthcheck-Endpoint ergänzt
fix: Quoting bei Dateinamen mit Leerzeichen
docs: Architekturdiagramm aktualisiert
chore: pre-commit-Hooks aktualisiert
```

## Merge-Request-Beschreibung
```
## Was
## Warum
## Wie getestet
```

## Allgemeine Regeln (alle Sprachen)
- Secrets nie ins Repo – weder im Code noch in Beispielen. Platzhalter wie `<TOKEN>` nutzen.
- Jede Verhaltensänderung bekommt einen Test bzw. eine Validierung.
- Dokumentation im selben Merge Request aktualisieren wie den Code.
- Der Agent `@reviewer` (oder `/review`) kann vorab einen Review-Durchgang machen.
