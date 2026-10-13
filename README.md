<!--
  TEMPLATE (Python-Flavor): Titel, Beschreibung und Schnellstart ersetzen.
  Tree View aktuell halten – er ist die Landkarte für Menschen und Agents.
-->

# hello-world (Python-Flavor)

Python-Variante des [OpenCode Basis-Templates](../../tree/main). Enthält ein kleines
CLI-Beispiel mit Tests, Linting (ruff), Typprüfung (mypy strict) und pre-commit-Hooks.

> Generische Beschreibung, alle Flavors und Pflegehinweise: siehe Branch **`main`**.

## Schnellstart

```bash
python -m venv .venv && source .venv/bin/activate
make install
python -m hello_world Ada     # → Hello, Ada!
make check
```

In OpenCode: `/check`, `/review`, `@reviewer`, `@docs-writer`.

## Struktur

```
.
├── AGENTS.md                     # ★ OpenCode-Regeln: Befehle, Struktur, Python-Regeln
├── opencode.json                 # lädt CONTRIBUTING.md + docs/conventions.md immer mit
├── README.md                     # diese Datei
├── CONTRIBUTING.md               # Workflow, Commits (gemeinsam mit main)
├── CHANGELOG.md
├── Makefile                      # install | lint | fmt | test | cov | check
├── pyproject.toml                # Paket, Abhängigkeiten, Config für pytest, ruff, mypy
├── .editorconfig
├── .gitignore                    # + Python-Artefakte (.venv, __pycache__, caches)
├── .pre-commit-config.yaml       # generische Hooks + ruff / ruff-format
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
│       └── new-module/SKILL.md   # ★ Python: neues Modul inkl. Test, Typen, Doku
│
├── docs/
│   ├── architecture.md           # CLI- und Logikschicht, Mermaid-Diagramm
│   ├── conventions.md            # Python-Stil, Benennung, Fehlerbehandlung (immer geladen)
│   ├── testing.md                # pytest-Strategie, Fixtures (bei Bedarf)
│   └── decisions/
│       ├── 0000-template.md
│       ├── 0001-flavor-branches.md
│       └── 0002-src-layout.md    # ★ Python: warum src/-Layout
│
├── src/hello_world/              # Beispielcode – durch eigenes Paket ersetzen
│   ├── __init__.py               #   öffentliche API
│   ├── __main__.py               #   CLI-Einstiegspunkt
│   └── greeting.py               #   Fachlogik
└── tests/
    └── test_greeting.py          # parametrisierte Tests + CLI-Test
```

## Nach dem Fork anpassen

```bash
grep -rn "TEMPLATE:" --include="*.md" .
```

- [ ] Paket `hello_world` umbenennen (Ordner, `pyproject.toml`, Imports, Skill `new-module`)
- [ ] `README.md`, `AGENTS.md` – Beschreibung, Befehle, Regeln
- [ ] `docs/conventions.md`, `docs/architecture.md`, `docs/testing.md`
- [ ] `CHANGELOG.md` zurücksetzen, `LICENSE` ergänzen
- [ ] `pre-commit autoupdate` für aktuelle Hook-Versionen
