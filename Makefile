# Python-Flavor – einheitliche Ziele: lint | fmt | test | check
PY ?= python
.PHONY: help install lint fmt test cov check

help:
	@echo "install  Dev-Umgebung installieren (pip install -e .[dev])"
	@echo "lint     ruff + Format-Check + mypy"
	@echo "fmt      automatisch formatieren und Imports sortieren"
	@echo "test     pytest inkl. Doctests"
	@echo "cov      Tests mit Coverage-Report"
	@echo "check    lint + test"

install:
	$(PY) -m pip install -e ".[dev]"
	pre-commit install

lint:
	ruff check .
	ruff format --check .
	mypy

fmt:
	ruff check --fix .
	ruff format .

test:
	$(PY) -m pytest

cov:
	$(PY) -m pytest --cov=hello_world --cov-report=term-missing

check: lint test
