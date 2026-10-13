<!--
  TEMPLATE (Bash-Flavor): Wird bei jeder OpenCode-Session automatisch geladen.
  Kurz halten, Details in docs/. Hello-World durch eigene Skripte ersetzen.
-->

# AGENTS.md – hello (Bash)

## Projekt in einem Satz
Admin-Skript, das Begrüßungen ausgibt. Beispiel für ein OpenCode-fähiges Bash-Repo.

## Befehle
```bash
bin/hello.sh Ada          # Skript ausführen
bin/hello.sh -h           # Hilfe

make lint    # shellcheck + shfmt -d
make fmt     # shfmt -w
make test    # bats tests/
make check   # lint + test – muss vor jedem Commit grün sein
bats tests/greeting.bats  # einzelne Testdatei
```
Voraussetzungen: `shellcheck`, `shfmt`, `bats` (RHEL/Fedora: `dnf install ShellCheck shfmt bats`).

## Struktur
- `bin/*.sh` – ausführbare Einstiegsskripte: Optionen parsen, `main`, Traps
- `lib/*.sh` – gesourcte Funktionsbibliotheken, kein Code außerhalb von Funktionen
- `lib/common.sh` – Logging (`log_info`, `log_error`, `log_debug`), `die`, `require_cmd`
- `tests/*.bats` – bats-Tests; `<lib>.bats` für Funktionen, `<skript>.bats` für Aufrufe

## Wichtige Regeln
- Bash ≥ 4.4, Shebang `#!/usr/bin/env bash`, immer `set -Eeuo pipefail`.
- Jede Variablenexpansion in doppelten Anführungszeichen und mit Klammern: `"${var}"`.
- Logs und Fehler auf **stderr**, Nutzdaten auf **stdout**.
- Exit-Codes: 0 OK, 1 Laufzeitfehler, 2 Bedienfehler.
- Skripte, die Systeme verändern, brauchen `-n` (Dry-Run) und müssen idempotent sein.
- Neue Funktion ⇒ bats-Test. Nutzersichtbare Änderungen in `CHANGELOG.md`.

## Nicht tun
- Kein `eval`, kein Parsen von `ls`, kein `curl … | bash`.
- Kein `sudo` innerhalb von Skripten – Rechte prüfen und mit Hinweis abbrechen.
- Keine Skripte gegen echte Server ausführen, um sie zu „testen“.
- Keine Secrets in Skripten oder Argumenten (landen in `ps`/History) – Umgebungsvariablen oder Dateien mit `0600`.
- `# shellcheck disable=` nur mit Begründung im Kommentar.

## Weiterführende Doku (bei Bedarf lesen)
- Architektur: @docs/architecture.md
- Teststrategie: @docs/testing.md
- Entscheidungen: @docs/decisions/
- Konventionen (immer geladen via opencode.json): docs/conventions.md
