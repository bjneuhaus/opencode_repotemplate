---
name: new-module
description: Legt ein neues Python-Modul unter src/ an, inklusive Test, Typen, Doku und CHANGELOG-Eintrag. Verwenden, wenn neue Funktionalität als eigenes Modul hinzukommt.
---

<!-- TEMPLATE (Python): Paketname hello_world durch eigenen ersetzen. -->

# Neues Python-Modul anlegen

1. `src/hello_world/<name>.py` mit Modul-Docstring. Reine, typisierte Funktionen, keine I/O.
2. `tests/test_<name>.py`: mindestens ein Test pro öffentlicher Funktion, Randfälle parametrisiert.
3. Öffentliche Funktionen in `src/hello_world/__init__.py` importieren und in `__all__` aufnehmen.
4. `make check` – ruff, mypy und pytest müssen grün sein.
5. Modultabelle in `docs/architecture.md` und Tree View in `README.md` ergänzen.
6. `CHANGELOG.md` → `[Unreleased]` → `Added`.

## Vorlage Modul
```python
"""<Ein Satz, wofür das Modul da ist>."""


def beispiel(wert: str) -> str:
    """<Was die Funktion tut>.

    >>> beispiel("x")
    'x'
    """
    return wert
```

## Vorlage Test
```python
from hello_world.<name> import beispiel


def test_beispiel_gibt_wert_zurueck() -> None:
    assert beispiel("x") == "x"
```
