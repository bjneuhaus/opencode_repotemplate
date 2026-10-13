<!-- TEMPLATE (Bash): Immer geladen – kompakt halten. -->

# Konventionen (Bash)

## Werkzeuge
- `shellcheck` (Config: `.shellcheckrc`) muss ohne Befund durchlaufen.
- `shfmt` formatiert; Einstellungen kommen aus `.editorconfig` (2 Spaces, `switch_case_indent`).

## Grundgerüst jedes Skripts
```bash
#!/usr/bin/env bash
set -Eeuo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
readonly SCRIPT_DIR
source "${SCRIPT_DIR}/../lib/common.sh"

main() { ...; }

trap cleanup EXIT
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then main "$@"; fi
```

## Stil
- `[[ … ]]` statt `[ … ]`, `$(…)` statt Backticks, `(( … ))` für Arithmetik.
- Variablen in Funktionen mit `local`, Konstanten mit `readonly`.
- `printf` statt `echo` für alles, was nicht reiner Text ist.
- Optionen mit `getopts`; jedes Skript hat `-h`.
- Temporäre Dateien nur mit `mktemp`, Aufräumen im `EXIT`-Trap.
- `--` vor Dateiargumenten: `rm -rf -- "${dir}"`.
- Bedienfehler mit `exit 2` direkt beenden (nicht `return`), sonst meldet der ERR-Trap einen Fehler.

## Benennung
| Was | Stil | Beispiel |
|---|---|---|
| Skripte | `kebab-case.sh` | `rotate-logs.sh` |
| Funktionen, lokale Variablen | `snake_case` | `require_cmd`, `local target_dir` |
| Globale/Umgebungsvariablen, Konstanten | `UPPER_SNAKE_CASE` | `SCRIPT_DIR`, `VERBOSE` |
| Private Library-Variablen | `_UPPER_SNAKE` | `_COMMON_SH_LOADED` |

## Muster
```bash
# Gut: gequotet, Fehler abgefangen, Log auf stderr
for file in "${log_dir}"/*.log; do
  [[ -e "${file}" ]] || continue
  gzip -- "${file}" || log_error "Konnte ${file} nicht komprimieren"
done

# Schlecht: ungequotet, ls geparst, bricht bei Leerzeichen
for f in $(ls $LOG_DIR/*.log); do gzip $f; done
```
