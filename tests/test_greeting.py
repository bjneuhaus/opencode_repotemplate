import pytest

from hello_world.__main__ import main
from hello_world.greeting import greet


def test_greet_default() -> None:
    assert greet() == "Hello, World!"


@pytest.mark.parametrize(
    ("name", "expected"),
    [("Ada", "Hello, Ada!"), ("  Linus  ", "Hello, Linus!"), ("   ", "Hello, World!")],
)
def test_greet_names(name: str, expected: str) -> None:
    assert greet(name) == expected


def test_cli_prints_greeting(capsys: pytest.CaptureFixture[str]) -> None:
    assert main(["Grace"]) == 0
    assert capsys.readouterr().out.strip() == "Hello, Grace!"
