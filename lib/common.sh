# shellcheck shell=bash
#
# common.sh – gemeinsame Hilfsfunktionen (Logging, Abbruch, Voraussetzungen).
# Nur sourcen, nicht direkt ausführen.

[[ -n "${_COMMON_SH_LOADED-}" ]] && return 0
readonly _COMMON_SH_LOADED=1

VERBOSE="${VERBOSE:-0}"

# Logging immer auf stderr, damit stdout für Nutzdaten frei bleibt.
log() {
  local level="$1"
  shift
  printf '%s [%s] %s\n' "$(date +'%Y-%m-%dT%H:%M:%S%z')" "${level}" "$*" >&2
}

log_info() { log INFO "$@"; }
log_error() { log ERROR "$@"; }
log_debug() {
  if [[ "${VERBOSE}" == "1" ]]; then
    log DEBUG "$@"
  fi
}

die() {
  log_error "$@"
  exit 1
}

# Bricht ab, wenn eines der Kommandos fehlt: require_cmd oc jq
require_cmd() {
  local cmd
  for cmd in "$@"; do
    command -v -- "${cmd}" > /dev/null 2>&1 || die "Benötigtes Kommando fehlt: ${cmd}"
  done
}
