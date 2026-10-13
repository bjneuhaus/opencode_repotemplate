<!--
  TEMPLATE: Generische Vorlage aus dem main-Branch. In jedem Flavor-Branch
  (flavor/python, flavor/bash, flavor/yaml, ...) ist diese Datei bereits
  sprachspezifisch ausgefüllt. Wenn du von main aus startest: Abschnitte
  unten ausfüllen, Platzhalter <...> ersetzen. Kurz halten (< 150 Zeilen).
-->

# AGENTS.md – <projektname>

## Projekt in einem Satz
<Was macht das Projekt, für wen?>

## Befehle
Alle Flavors bieten dieselbe Schnittstelle über `make`:
```bash
make lint    # Statische Prüfungen
make fmt     # Automatisch formatieren
make test    # Tests ausführen
make check   # lint + test – muss vor jedem Commit grün sein
```
<Weitere Befehle: Setup, Ausführen, Deployment ...>

## Struktur
- `<pfad>/` – <wofür>
- `docs/` – Architektur, Konventionen, Tests, Entscheidungen (ADRs)

## Wichtige Regeln
- <Harte Regeln, die bei jeder Änderung gelten>
- Keine neuen Abhängigkeiten oder Tools ohne Rückfrage.
- Nutzersichtbare Änderungen in `CHANGELOG.md` unter `[Unreleased]` eintragen.

## Nicht tun
- Keine Secrets, Tokens oder Passwörter ausgeben, in Dateien schreiben oder committen.
- Tests oder Lint-Regeln nicht abschwächen, um sie grün zu bekommen.
- <Projektspezifische Verbote, z.B. "kein kubectl apply gegen Produktion">

## Weiterführende Doku (bei Bedarf lesen)
- Architektur: @docs/architecture.md
- Teststrategie: @docs/testing.md
- Entscheidungen: @docs/decisions/
- Code-Konventionen werden über `opencode.json` immer geladen: docs/conventions.md
