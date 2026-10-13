"""Fachlogik: Begrüßungen erzeugen."""


def greet(name: str = "World") -> str:
    """Gibt eine Begrüßung für ``name`` zurück.

    Leere oder nur aus Leerzeichen bestehende Namen fallen auf "World" zurück.

    >>> greet("Ada")
    'Hello, Ada!'
    """
    cleaned = name.strip()
    return f"Hello, {cleaned or 'World'}!"
