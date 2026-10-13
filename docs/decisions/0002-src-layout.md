# 0002: src-Layout für Python-Pakete

- **Status:** Akzeptiert
- **Datum:** 2026-10-13

## Kontext
Im flachen Layout importieren Tests versehentlich den lokalen Ordner statt des installierten Pakets.

## Entscheidung
Code liegt unter `src/<paket>/`; pytest findet ihn über `pythonpath = ["src"]`.

## Alternativen
- **Flaches Layout:** einfacher, aber fehleranfällig bei Imports und Packaging.

## Konsequenzen
- `python -m hello_world` braucht eine Installation (`make install`).
