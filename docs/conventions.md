<!-- TEMPLATE (Python): Immer geladen – kompakt halten. -->

# Konventionen (Python)

## Werkzeuge
- `ruff format` formatiert, `ruff check` lintet (inkl. Sicherheitsregeln `S`), `mypy --strict` prüft Typen.
- Konfiguration ausschließlich in `pyproject.toml`.

## Stil
- Zeilenlänge 100. Moderne Typ-Syntax: `list[str]`, `str | None`.
- Docstrings im Google-Stil für alles Öffentliche, gern mit Doctest-Beispiel.
- `pathlib.Path` statt String-Pfade, f-Strings statt `%`/`format`.
- Logging über `logging.getLogger(__name__)`, kein `print` außerhalb der CLI.

## Benennung
| Was | Stil | Beispiel |
|---|---|---|
| Module, Funktionen, Variablen | `snake_case` | `greeting.py`, `greet()` |
| Klassen | `PascalCase` | `GreetingConfig` |
| Konstanten | `UPPER_SNAKE_CASE` | `DEFAULT_NAME` |
| Tests | `test_<verhalten>` | `test_greet_strips_whitespace` |

## Muster
```python
# Gut: reine Funktion, typisiert, testbar
def greet(name: str = "World") -> str:
    return f"Hello, {name.strip() or 'World'}!"

# Schlecht: Logik und Ausgabe vermischt, keine Typen
def greet(name):
    print("Hello, " + name + "!")
```

## Fehlerbehandlung
- Eigene Exceptions erben von einer Basisklasse pro Paket (`HelloWorldError`).
- CLI fängt bekannte Fehler ab, gibt eine verständliche Meldung auf stderr aus und endet mit Exit-Code ≠ 0.
- Kein nacktes `except:`; `except Exception` nur an der äußersten Grenze.
- `subprocess` nie mit `shell=True` und ungeprüfter Eingabe.
