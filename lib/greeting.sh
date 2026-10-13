# shellcheck shell=bash
#
# greeting.sh – Fachlogik: Begrüßungen erzeugen.
# Reine Funktionen: Eingabe über Argumente, Ergebnis auf stdout, kein Logging.

[[ -n "${_GREETING_SH_LOADED-}" ]] && return 0
readonly _GREETING_SH_LOADED=1

# greet [NAME] – gibt "Hello, NAME!" aus; leere Namen werden zu "World".
greet() {
  local name="${1-}"
  # führende und abschließende Leerzeichen entfernen
  name="${name#"${name%%[![:space:]]*}"}"
  name="${name%"${name##*[![:space:]]}"}"
  printf 'Hello, %s!\n' "${name:-World}"
}
