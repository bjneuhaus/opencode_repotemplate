#!/usr/bin/env bats
# Unit-Tests für lib/greeting.sh

setup() {
  # shellcheck source=../lib/greeting.sh
  source "${BATS_TEST_DIRNAME}/../lib/greeting.sh"
}

@test "greet ohne Argument begrüßt World" {
  run greet
  [ "${status}" -eq 0 ]
  [ "${output}" = "Hello, World!" ]
}

@test "greet mit Namen" {
  run greet "Ada"
  [ "${output}" = "Hello, Ada!" ]
}

@test "greet entfernt Leerzeichen" {
  run greet "  Linus  "
  [ "${output}" = "Hello, Linus!" ]
}

@test "greet mit nur Leerzeichen fällt auf World zurück" {
  run greet "   "
  [ "${output}" = "Hello, World!" ]
}
