# 0002: bats für Shell-Tests

- **Status:** Akzeptiert
- **Datum:** 2026-10-13

## Kontext
Admin-Skripte werden oft nur manuell getestet; Regressionen fallen erst im Betrieb auf.

## Entscheidung
Tests mit [bats-core](https://github.com/bats-core/bats-core). Libraries werden gesourct,
Skripte als Prozess aufgerufen, externe Kommandos per PATH-Stub ersetzt.

## Alternativen
- **shunit2:** älter, weniger aktiv gepflegt, umständlichere Syntax.
- **Python/pytest mit subprocess:** zusätzliche Sprache im Repo.

## Konsequenzen
- `bats` muss lokal und in der CI installiert sein.
