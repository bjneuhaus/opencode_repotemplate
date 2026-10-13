<!-- TEMPLATE (Python): Teststrategie. Bei Bedarf gelesen. -->

# Tests (Python)

## Ausführen
```bash
make test                  # alles inkl. Doctests
pytest -k greet            # nach Namen filtern
make cov                   # mit Coverage-Report
```

## Aufbau
- `tests/test_<modul>.py` spiegelt `src/hello_world/<modul>.py`.
- Fachlogik: direkte Aufrufe, Randfälle mit `@pytest.mark.parametrize`.
- CLI: `main([...])` aufrufen, Ausgabe über `capsys` prüfen.
- Dateisystem: `tmp_path`-Fixture, Umgebungsvariablen: `monkeypatch.setenv`.

## Beispiel
```python
@pytest.mark.parametrize(("name", "expected"), [("Ada", "Hello, Ada!"), ("", "Hello, World!")])
def test_greet_names(name: str, expected: str) -> None:
    assert greet(name) == expected
```

## Regeln
- Jeder Bugfix bekommt einen Regressionstest.
- Kein Netzwerk, keine echten Systeme – externe Aufrufe hinter einer Funktion kapseln und dort mocken.
- Gemeinsame Fixtures in `tests/conftest.py`.
