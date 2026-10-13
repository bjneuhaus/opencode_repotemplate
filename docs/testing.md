<!-- TEMPLATE (Bash): Teststrategie. Bei Bedarf gelesen. -->

# Tests (Bash)

## Ausführen
```bash
make test                       # alle bats-Tests
bats tests/greeting.bats        # eine Datei
bats -f "Leerzeichen" tests/    # nach Testnamen filtern
```

## Aufbau
- `tests/<lib>.bats` – Unit-Tests: Library in `setup()` sourcen, Funktion mit `run` aufrufen.
- `tests/<skript>.bats` – Integrationstests: Skript als Prozess starten, Exit-Code und Ausgabe prüfen.
- `run --separate-stderr` (bats ≥ 1.5), um stdout und stderr getrennt zu prüfen.

## Externe Kommandos ersetzen
Kommandos wie `oc`, `systemctl` oder `curl` nie echt aufrufen. Stattdessen Stubs vor den PATH legen:
```bash
setup() {
  STUB_DIR="${BATS_TEST_TMPDIR}/bin"
  mkdir -p "${STUB_DIR}"
  printf '#!/usr/bin/env bash\necho "stub oc $*"\n' > "${STUB_DIR}/oc"
  chmod +x "${STUB_DIR}/oc"
  PATH="${STUB_DIR}:${PATH}"
}
```

## Regeln
- Jeder Bugfix bekommt einen Regressionstest.
- Tests schreiben nur nach `${BATS_TEST_TMPDIR}`, nie ins Repo oder nach `/tmp` direkt.
