# Bash-Flavor – einheitliche Ziele: lint | fmt | test | check
# Benötigt: shellcheck, shfmt, bats (z.B. dnf install ShellCheck shfmt bats)
SH_FILES := $(shell find bin lib -type f -name '*.sh')
.PHONY: help lint fmt test check

help:
	@echo "lint   shellcheck + shfmt -d"
	@echo "fmt    shfmt -w (Formatierung anwenden)"
	@echo "test   bats tests/"
	@echo "check  lint + test"

lint:
	shellcheck $(SH_FILES)
	shfmt -d bin lib tests

fmt:
	shfmt -w bin lib tests

test:
	bats tests/

check: lint test
