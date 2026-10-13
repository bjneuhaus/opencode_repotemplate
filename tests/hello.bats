#!/usr/bin/env bats
# Integrationstests für bin/hello.sh (Aufruf als Prozess)

setup() {
  SCRIPT="${BATS_TEST_DIRNAME}/../bin/hello.sh"
}

@test "hello.sh gibt Begrüßung aus" {
  run "${SCRIPT}" Grace
  [ "${status}" -eq 0 ]
  [ "${output}" = "Hello, Grace!" ]
}

@test "hello.sh -h zeigt Hilfe" {
  run "${SCRIPT}" -h
  [ "${status}" -eq 0 ]
  [[ "${output}" == *"Nutzung:"* ]]
}

@test "unbekannte Option endet mit Exit-Code 2" {
  run "${SCRIPT}" -x
  [ "${status}" -eq 2 ]
}

@test "zu viele Argumente enden mit Exit-Code 2" {
  run "${SCRIPT}" a b
  [ "${status}" -eq 2 ]
}

@test "-v schreibt Debug-Log nur auf stderr" {
  run --separate-stderr "${SCRIPT}" -v Ada
  [ "${output}" = "Hello, Ada!" ]
  [[ "${stderr}" == *"DEBUG"* ]]
}
