<!--
  TEMPLATE (YAML-Flavor): Titel, Beschreibung und Schnellstart ersetzen.
  Tree View aktuell halten.
-->

# hello (YAML-Flavor: OpenShift / Kubernetes)

YAML-Variante des [OpenCode Basis-Templates](../../tree/main) für reine Manifest-Projekte
auf OpenShift. Enthält eine Hello-World-Webseite (httpd) als Kustomize-Base mit
`dev`- und `prod`-Overlay sowie eine dreistufige Validierung:
yamllint → kube-linter → kubeconform.

> Generische Beschreibung, alle Flavors und Pflegehinweise: siehe Branch **`main`**.

## Schnellstart

```bash
# Werkzeuge (Beispiele): pip install yamllint pre-commit
#   kube-linter, kubeconform, yamlfmt: Release-Binaries von GitHub bzw. brew
# 1. Image-Tag in deploy/overlays/dev/kustomization.yaml pinnen ("PIN-ME" ersetzen)
make check
oc login ... && make diff ENV=dev        # nur lesend
```

In OpenCode: `/check`, `/review`, `@reviewer`, `@docs-writer`.

## Struktur

```
.
├── AGENTS.md                     # ★ OpenCode-Regeln: Befehle, Pflichtfelder, kein oc apply
├── opencode.json                 # lädt CONTRIBUTING.md + docs/conventions.md immer mit
├── README.md                     # diese Datei
├── CONTRIBUTING.md               # Workflow, Commits (gemeinsam mit main)
├── CHANGELOG.md
├── Makefile                      # render | lint | fmt | test | check | diff | clean
├── .editorconfig
├── .gitignore                    # + build/, kubeconfig
├── .pre-commit-config.yaml       # generische Hooks + yamllint
├── .yamllint.yaml                # ★ YAML-Stilregeln (Einrückung, Booleans, Duplikate)
├── .yamlfmt                      # ★ Formatter-Config für make fmt
├── .kube-linter.yaml             # ★ Best-Practice-Checks für Kubernetes-Objekte
│
├── .opencode/
│   ├── agents/
│   │   ├── reviewer.md           # @reviewer – read-only Review (gemeinsam)
│   │   └── docs-writer.md        # @docs-writer – Doku-Pflege (gemeinsam)
│   ├── commands/
│   │   ├── check.md              # /check – make check + Fehleranalyse (gemeinsam)
│   │   ├── review.md             # /review (gemeinsam)
│   │   └── changelog.md          # /changelog (gemeinsam)
│   └── skills/
│       ├── write-adr/SKILL.md    # ADR anlegen (gemeinsam)
│       └── new-overlay/SKILL.md  # ★ YAML: neue Umgebung als Overlay anlegen
│
├── docs/
│   ├── architecture.md           # Laufzeit- und Kustomize-Diagramm, Ressourcentabelle
│   ├── conventions.md            # Labels, Pflichtfelder, Image-Pinning (immer geladen)
│   ├── testing.md                # Validierungsstufen, Offline-Modus (bei Bedarf)
│   └── decisions/
│       ├── 0000-template.md
│       ├── 0001-flavor-branches.md
│       ├── 0002-kustomize-und-gitops.md
│       └── 0003-httpd-ohne-readonly-rootfs.md
│
└── deploy/
    ├── base/                     # umgebungsneutral, kein Namespace, kein Image-Tag
    │   ├── kustomization.yaml    #   Ressourcenliste, Labels, configMapGenerator
    │   ├── serviceaccount.yaml   #   eigener SA ohne Token-Mount
    │   ├── deployment.yaml       #   httpd mit Probes, Limits, Security Context
    │   ├── service.yaml          #   ClusterIP :8080
    │   ├── route.yaml            #   OpenShift Route, TLS edge
    │   ├── networkpolicy.yaml    #   nur Router darf zugreifen
    │   └── content/
    │       └── index.html        #   Webseiteninhalt → ConfigMap
    └── overlays/
        ├── dev/
        │   └── kustomization.yaml   # ns hello-dev, 1 Replica, Image-Tag
        └── prod/
            ├── kustomization.yaml   # ns hello-prod, 2 Replicas, Digest
            ├── pdb.yaml             # PodDisruptionBudget
            └── patch-resources.yaml # höhere Requests/Limits
```

## Nach dem Fork anpassen

```bash
grep -rn "TEMPLATE:\|PIN-ME" .
```

- [ ] Image-Tag (dev) und Digest (prod) pinnen – `PIN-ME` ersetzen
- [ ] Namen `hello` / Namespaces `hello-<env>` durch eigene ersetzen
- [ ] Eigenes Image: möglichst `readOnlyRootFilesystem: true`, dann ADR 0003 und Annotation entfernen
- [ ] `K8S_VERSION` im Makefile an die OpenShift-Version anpassen
- [ ] `README.md`, `AGENTS.md`, `docs/*` anpassen
- [ ] Unter reinem Kubernetes: `route.yaml` durch Ingress ersetzen, NetworkPolicy-Selector für den Ingress-Controller anpassen
- [ ] `CHANGELOG.md` zurücksetzen, `LICENSE` ergänzen, `pre-commit autoupdate`
