---
name: new-script
description: Legt ein neues Bash-Skript unter bin/ nach Projektstandard an, inklusive Hilfe, Dry-Run-Option, Traps und bats-Tests. Verwenden, wenn ein neues Admin- oder Automatisierungsskript entstehen soll.
---

<!-- TEMPLATE (Bash): Grundgerüst an eigene Standards anpassen. -->

# Neues Bash-Skript anlegen

1. `bin/<name>.sh` aus dem Grundgerüst unten erstellen, `chmod +x`.
2. Wiederverwendbare Logik als Funktionen in `lib/<thema>.sh` (mit Include-Guard), nicht im Skript.
3. Verändert das Skript Systeme: `-n` (Dry-Run) implementieren und jede Änderung über `run_cmd` leiten.
4. Externe Kommandos am Anfang von `main` mit `require_cmd` prüfen.
5. Tests: `tests/<name>.bats` (Aufruf, `-h`, Exit-Code 2 bei Fehlbedienung, Dry-Run) und ggf. `tests/<thema>.bats`.
6. `make check`, dann Tree View in `README.md` und `CHANGELOG.md` ergänzen.

## Grundgerüst
```bash
#!/usr/bin/env bash
#
# <name>.sh – <ein Satz, was das Skript tut>.
# Nutzung: <name>.sh [-n] [-v] [-h] <ARG>

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
readonly SCRIPT_DIR
readonly SCRIPT_NAME="${0##*/}"
DRY_RUN=0

# shellcheck source=../lib/common.sh
source "${SCRIPT_DIR}/../lib/common.sh"

usage() {
  cat << USAGE
Nutzung: ${SCRIPT_NAME} [-n] [-v] [-h] <ARG>
  -n  Dry-Run: nur anzeigen, was passieren würde
  -v  ausführliche Logs
  -h  Hilfe
USAGE
}

# Führt ein Kommando aus – oder zeigt es im Dry-Run nur an.
run_cmd() {
  if ((DRY_RUN)); then
    log_info "[dry-run] $*"
  else
    "$@"
  fi
}

main() {
  local opt
  while getopts ":nvh" opt; do
    case "${opt}" in
      n) DRY_RUN=1 ;;
      v) VERBOSE=1 ;;
      h)
        usage
        return 0
        ;;
      *)
        usage >&2
        exit 2
        ;;
    esac
  done
  shift $((OPTIND - 1))
  (($# == 1)) || {
    usage >&2
    exit 2
  }

  require_cmd <kommandos>
  run_cmd <aktion> "${1}"
}

trap 'log_error "Fehler in Zeile ${LINENO}: ${BASH_COMMAND}"' ERR
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
```
