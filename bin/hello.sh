#!/usr/bin/env bash
#
# hello.sh – gibt eine Begrüßung aus.
#
# Nutzung: hello.sh [-v] [-h] [NAME]
#   -v  ausführliche Log-Ausgabe auf stderr
#   -h  diese Hilfe
#
# Exit-Codes: 0 OK, 1 Laufzeitfehler, 2 falsche Bedienung

set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
readonly SCRIPT_DIR
readonly SCRIPT_NAME="${0##*/}"

# shellcheck source=../lib/common.sh
source "${SCRIPT_DIR}/../lib/common.sh"
# shellcheck source=../lib/greeting.sh
source "${SCRIPT_DIR}/../lib/greeting.sh"

usage() {
  cat << USAGE
Nutzung: ${SCRIPT_NAME} [-v] [-h] [NAME]

Gibt "Hello, NAME!" aus. Ohne NAME wird "World" begrüßt.

Optionen:
  -v  ausführliche Log-Ausgabe auf stderr
  -h  diese Hilfe anzeigen
USAGE
}

cleanup() {
  # Platz für Aufräumarbeiten, z.B. temporäre Verzeichnisse:
  # [[ -n "${TMP_DIR-}" ]] && rm -rf -- "${TMP_DIR}"
  :
}

main() {
  local opt
  while getopts ":vh" opt; do
    case "${opt}" in
      v) VERBOSE=1 ;;
      h)
        usage
        return 0
        ;;
      \?)
        log_error "Unbekannte Option: -${OPTARG}"
        usage >&2
        exit 2
        ;;
      *)
        usage >&2
        exit 2
        ;;
    esac
  done
  shift $((OPTIND - 1))

  if (($# > 1)); then
    log_error "Zu viele Argumente."
    usage >&2
    exit 2
  fi

  log_debug "Begrüße '${1-World}'"
  greet "${1-}"
}

trap cleanup EXIT
trap 'log_error "Fehler in Zeile ${LINENO}: ${BASH_COMMAND}"' ERR

# Nur ausführen, wenn direkt aufgerufen (nicht beim Sourcen in Tests)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
