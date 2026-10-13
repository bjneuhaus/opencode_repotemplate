# OpenCode Basis-Template

Basis-Repository für Projekte, die mit [OpenCode](https://opencode.ai) entwickelt werden.
Der `main`-Branch enthält nur die **generische Struktur**. Sprach- bzw. plattformspezifische
Varianten liegen in eigenen **Flavor-Branches**.

> **Du bist im `main`-Branch.** Für ein neues Projekt wechselst du in den passenden Flavor
> und startest von dort.

## Flavors

| Branch | Für | Werkzeuge |
|---|---|---|
| `flavor/python` | Python-Tools und -Services | ruff, pytest, mypy, pre-commit |
| `flavor/bash` | Admin-Skripte, Automatisierung | shellcheck, shfmt, bats |
| `flavor/yaml` | OpenShift-/Kubernetes-Manifeste | kustomize, yamllint, kubeconform, kube-linter |
| `main` | Generische Basis, Ausgangspunkt für neue Flavors | – |

Alle Flavors bieten dieselbe Schnittstelle: `make lint`, `make fmt`, `make test`, `make check`.
Dadurch funktionieren die OpenCode-Commands (`/check`, `/review`) überall gleich.

## Neues Projekt starten

```bash
# Variante A: Nur den gewünschten Flavor übernehmen (empfohlen)
git clone --branch flavor/python --single-branch <repo-url> mein-projekt
cd mein-projekt
git branch -m flavor/python main          # Flavor wird zum main des neuen Projekts
git remote set-url origin <neue-repo-url>

# Variante B: Fork über GitLab/GitHub/Gitea, danach
git checkout flavor/python
git checkout -b main-neu                  # oder Default-Branch in der Oberfläche umstellen
```

Danach in jeder Markdown-Datei die `<!-- TEMPLATE: ... -->`-Kommentare abarbeiten:

```bash
grep -rn "TEMPLATE:" --include="*.md" .
```

## Gemeinsame Struktur (in allen Branches)

```
.
├── AGENTS.md                     # ★ Hauptregeln für OpenCode – bei jeder Session automatisch geladen
├── opencode.json                 # OpenCode-Config: lädt CONTRIBUTING.md + docs/conventions.md immer mit
├── README.md                     # Überblick, Schnellstart, Tree View (pro Flavor angepasst)
├── CONTRIBUTING.md               # Workflow, Commits, allgemeine Regeln (gemeinsam, nicht in Flavors ändern)
├── CHANGELOG.md                  # Änderungshistorie nach "Keep a Changelog"
├── Makefile                      # Einheitliche Ziele lint | fmt | test | check (pro Flavor gefüllt)
├── .editorconfig                 # Einrückung, Zeilenenden, Encoding
├── .gitignore
├── .pre-commit-config.yaml       # Git-Hooks; Flavors ergänzen eigene Linter
│
├── .opencode/
│   ├── agents/
│   │   ├── reviewer.md           # @reviewer – read-only Review gegen Konventionen (gemeinsam)
│   │   └── docs-writer.md        # @docs-writer – pflegt Doku (gemeinsam)
│   ├── commands/
│   │   ├── check.md              # /check – make check ausführen, Fehler erklären (gemeinsam)
│   │   ├── review.md             # /review – Review via @reviewer (gemeinsam)
│   │   └── changelog.md          # /changelog – CHANGELOG aus Commits (gemeinsam)
│   └── skills/
│       └── write-adr/SKILL.md    # ADR anlegen (gemeinsam); Flavors ergänzen eigene Skills
│
└── docs/
    ├── architecture.md           # Aufbau und Datenfluss (pro Flavor mit Beispiel)
    ├── conventions.md            # Code-Konventionen, immer geladen (pro Flavor)
    ├── testing.md                # Teststrategie, bei Bedarf gelesen (pro Flavor)
    └── decisions/                # Architecture Decision Records
        ├── 0000-template.md      #   Vorlage
        └── 0001-flavor-branches.md  # Warum Flavors als Branches
```

### Wie OpenCode die Dateien nutzt

| Datei(en) | Wann geladen | Zweck |
|---|---|---|
| `AGENTS.md` | Immer, automatisch | Kurzer Kern: Befehle, Struktur, harte Regeln |
| `opencode.json` → `instructions` | Immer | Regeln, die bei fast jeder Änderung gelten |
| `@docs/...` in AGENTS.md | Bei Bedarf | Details, die nur manchmal gebraucht werden |
| `.opencode/agents/*.md` | Bei `@name` oder per Tab | Rollen mit eigenen Rechten |
| `.opencode/commands/*.md` | Bei `/name` | Wiederkehrende Prompts |
| `.opencode/skills/*/SKILL.md` | Wenn die Aufgabe zur `description` passt | Mehrschrittige Abläufe |

## Pflege des Templates

**Gemeinsame Dateien** (CONTRIBUTING.md, Agents, `/check`, `/review`, `/changelog`, `write-adr`,
`docs/decisions/0000-template.md`) werden nur in `main` geändert und dann in alle Flavors gemergt:

```bash
for b in flavor/python flavor/bash flavor/yaml; do
  git checkout "$b" && git merge --no-edit main
done
git checkout main
```

**Flavor-spezifische Dateien** (AGENTS.md, README.md, Makefile, docs/architecture.md,
docs/conventions.md, docs/testing.md, .pre-commit-config.yaml, .gitignore) werden nur im
jeweiligen Flavor geändert. Ändert `main` eine davon, entstehen beim Merge Konflikte –
dann die Flavor-Version behalten und die generische Änderung von Hand übertragen.

### Neuen Flavor anlegen (z.B. Java)

```bash
git checkout main
git checkout -b flavor/java
```

1. `Makefile` mit `lint`, `fmt`, `test`, `check` füllen.
2. `AGENTS.md`, `docs/conventions.md`, `docs/testing.md`, `docs/architecture.md` ausfüllen.
3. Kleines Hello-World-Beispiel mit Test ergänzen, `make check` muss grün sein.
4. Linter-Hooks in `.pre-commit-config.yaml`, Build-Artefakte in `.gitignore`.
5. Mindestens einen flavor-spezifischen Skill unter `.opencode/skills/`.
6. README: Tree View und Schnellstart für den Flavor, Tabelle oben in **main** ergänzen.

## Hinweise

- Persönliche, projektübergreifende Regeln gehören nach `~/.config/opencode/AGENTS.md`, nicht ins Repo.
- Gibt es keine `AGENTS.md`, nutzt OpenCode eine vorhandene `CLAUDE.md`.
- Frontmatter-Felder von Agents und Commands können sich zwischen OpenCode-Versionen ändern
  (ältere Versionen nutzen z.B. `agent/` und `command/` im Singular). Siehe [opencode.ai/docs](https://opencode.ai/docs/).
