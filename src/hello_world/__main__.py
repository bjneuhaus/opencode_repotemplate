"""CLI-Einstiegspunkt: ``python -m hello_world [NAME]``."""

import argparse

from hello_world.greeting import greet


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Gibt eine Begrüßung aus.")
    parser.add_argument("name", nargs="?", default="World", help="Wer begrüßt wird")
    args = parser.parse_args(argv)
    print(greet(args.name))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
