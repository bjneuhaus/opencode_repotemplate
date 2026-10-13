<!--
  TEMPLATE (Python-Flavor): Wird bei jeder OpenCode-Session automatisch geladen.
  Kurz halten, Details in docs/. Hello-World durch dein Projekt ersetzen.
-->

# AGENTS.md – hello-world (Python)

## Projekt in einem Satz
CLI-Tool, das Begrüßungen ausgibt. Beispiel für ein OpenCode-fähiges Python-Repo.

## Befehle
```bash
python -m venv .venv && source .venv/bin/activate
make install                 # pip install -e ".[dev]" + pre-commit install
python -m hello_world Ada    # App ausführen

make lint    # ruff check + ruff format --check + mypy (strict)
make fmt     # automatisch formatieren
make test    # pytest inkl. Doctests
make check   # lint + test – muss vor jedem Commit grün sein
pytest tests/test_greeting.py::test_greet_default   # einzelner Test
```

## Struktur
- `src/hello_world/greeting.py` – Fachlogik (reine Funktionen, keine I/O)
- `src/hello_world/__main__.py` – CLI: nur Argument-Parsing, Ausgabe, Exit-Code
- `tests/test_<modul>.py` – pytest, spiegelt `src/`
- `pyproject.toml` – Abhängigkeiten und Config für pytest, ruff, mypy

## Wichtige Regeln
- Python ≥ 3.10, vollständige Type Hints (mypy strict), Docstrings für Öffentliches.
- Fachlogik ohne I/O; `print`/`input`/Dateizugriffe nur in der CLI-Schicht.
- Abhängigkeiten nur über `pyproject.toml`, nie ad hoc mit `pip install` – vorher fragen.
- Neue Funktion ⇒ neuer Test. Bugfix ⇒ zuerst Test, der den Bug zeigt.
- Nutzersichtbare Änderungen in `CHANGELOG.md` unter `[Unreleased]`.

## Nicht tun
- Nichts unter `.venv/`, `dist/`, `build/` bearbeiten.
- Keine Secrets ausgeben oder committen; Konfiguration über Umgebungsvariablen.
- Keine `# type: ignore`/`# noqa` ohne Begründung im Kommentar.
- Tests nicht abschwächen oder löschen, um sie grün zu bekommen.

## Weiterführende Doku (bei Bedarf lesen)
- Architektur: @docs/architecture.md
- Teststrategie: @docs/testing.md
- Entscheidungen: @docs/decisions/
- Konventionen (immer geladen via opencode.json): docs/conventions.md
