# Einheitliche Schnittstelle für alle Flavors: make lint | fmt | test | check
# Im main-Branch gibt es nur Platzhalter – wechsle in einen Flavor-Branch.
.PHONY: help lint fmt test check

help:
	@echo "Ziele: lint, fmt, test, check"
	@echo "Dies ist der generische main-Branch. Flavors: git branch -r | grep flavor/"

lint fmt test:
	@echo "Kein Flavor gewählt – '$@' ist in main nicht definiert."

check: lint test
