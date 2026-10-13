<!--
  TEMPLATE (Bash-Flavor): Titel, Beschreibung und Schnellstart ersetzen.
  Tree View aktuell halten.
-->

# hello (Bash-Flavor)

Bash-Variante des [OpenCode Basis-Templates](../../tree/main) für Admin- und
Automatisierungsskripte. Enthält ein Beispielskript mit Strict Mode, getopts, Traps,
Logging auf stderr sowie bats-Tests, shellcheck und shfmt.

> Generische Beschreibung, alle Flavors und Pflegehinweise: siehe Branch **`main`**.

## Schnellstart

```bash
sudo dnf install ShellCheck shfmt bats    # bzw. apt / brew
bin/hello.sh Ada                          # → Hello, Ada!
make check
pre-commit install                        # optional: Hooks bei jedem Commit
```

In OpenCode: `/check`, `/review`, `@reviewer`, `@docs-writer`.

## Struktur

```
.
├── AGENTS.md                     # ★ OpenCode-Regeln: Befehle, Struktur, Bash-Regeln
├── opencode.json                 # lädt CONTRIBUTING.md + docs/conventions.md immer mit
├── README.md                     # diese Datei
├── CONTRIBUTING.md               # Workflow, Commits (gemeinsam mit main)
├── CHANGELOG.md
├── Makefile                      # lint (shellcheck, shfmt -d) | fmt | test (bats) | check
├── .editorconfig                 # + shfmt-Einstellungen für *.sh und *.bats
├── .shellcheckrc                 # ★ shellcheck-Config inkl. optionaler Prüfungen
├── .gitignore
├── .pre-commit-config.yaml       # generische Hooks + shellcheck, shfmt, Shebang-Checks
│
├── .opencode/
│   ├── agents/
│   │   ├── reviewer.md           # @reviewer – read-only Review (gemeinsam)
│   │   └── docs-writer.md        # @docs-writer – Doku-Pflege (gemeinsam)
│   ├── commands/
│   │   ├── check.md              # /check – make check + Fehleranalyse (gemeinsam)
│   │   ├── review.md             # /review (gemeinsam)
│   │   └── changelog.md          # /changelog (gemeinsam)
│   └── skills/
│       ├── write-adr/SKILL.md    # ADR anlegen (gemeinsam)
│       └── new-script/SKILL.md   # ★ Bash: neues Skript mit Dry-Run, Traps, Tests
│
├── docs/
│   ├── architecture.md           # bin/ vs. lib/, Datenfluss
│   ├── conventions.md            # Strict Mode, Quoting, Benennung (immer geladen)
│   ├── testing.md                # bats, PATH-Stubs für oc/curl/systemctl (bei Bedarf)
│   └── decisions/
│       ├── 0000-template.md
│       ├── 0001-flavor-branches.md
│       └── 0002-bats-fuer-tests.md
│
├── bin/
│   └── hello.sh                  # Beispiel-Einstiegsskript (ausführbar)
├── lib/
│   ├── common.sh                 # Logging, die, require_cmd
│   └── greeting.sh               # Fachlogik
└── tests/
    ├── greeting.bats             # Unit-Tests für lib/greeting.sh
    └── hello.bats                # Integrationstests für bin/hello.sh
```

## Nach dem Fork anpassen

```bash
grep -rn "TEMPLATE:" --include="*.md" .
```

- [ ] `bin/hello.sh`, `lib/greeting.sh` und Tests durch eigene Skripte ersetzen (`lib/common.sh` behalten)
- [ ] `README.md`, `AGENTS.md` – Beschreibung, Befehle, Verbote (z.B. Zielsysteme)
- [ ] `docs/conventions.md`, `docs/architecture.md`, `docs/testing.md`
- [ ] Mindest-Bash-Version und Zielplattformen in AGENTS.md festlegen
- [ ] `CHANGELOG.md` zurücksetzen, `LICENSE` ergänzen
- [ ] `pre-commit autoupdate`
