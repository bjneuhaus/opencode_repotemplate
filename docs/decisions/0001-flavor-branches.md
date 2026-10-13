# 0001: Sprach-Flavors als Branches

- **Status:** Akzeptiert
- **Datum:** 2026-10-13

## Kontext
Das Team betreut Projekte in Bash, Python, OpenShift/Kubernetes-YAML und weiteren Sprachen.
Die OpenCode-Grundstruktur (AGENTS.md, Agents, Commands, Doku) ist überall gleich,
Tooling und Konventionen unterscheiden sich.

## Entscheidung
`main` enthält nur Generisches. Jeder Flavor lebt in `flavor/<name>`, abgezweigt von `main`.
Neue Projekte forken das Repo und starten vom passenden Flavor-Branch.
Generische Änderungen werden in `main` gemacht und in die Flavors gemergt.

## Alternativen
- **Ein Repo pro Flavor:** Generische Änderungen müssten mehrfach gepflegt werden.
- **Alle Flavors in Unterordnern von main:** Forks enthielten viel Ballast und müssten aufräumen.

## Konsequenzen
- Einheitliche Schnittstelle `make lint|fmt|test|check` in allen Flavors.
- Gemeinsame Dateien (CONTRIBUTING.md, Agents, generische Commands) in Flavors nicht ändern,
  sonst entstehen Merge-Konflikte.
