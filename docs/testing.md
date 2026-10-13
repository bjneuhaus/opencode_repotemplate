<!-- TEMPLATE (YAML): Validierungsstrategie. Bei Bedarf gelesen. -->

# Validierung (OpenShift / Kubernetes)

Manifeste werden in drei Stufen geprüft – lokal und in der CI identisch.

| Stufe | Werkzeug | Prüft | make |
|---|---|---|---|
| 1. Syntax & Stil | yamllint | YAML-Syntax, Einrückung, Duplikate, Booleans | `lint` |
| 2. Best Practices | kube-linter | Probes, Limits, Security Context, Tags, NetworkPolicy | `lint` |
| 3. Schema | kubeconform | Felder und Typen gegen die API-Schemas (inkl. Route-CRD) | `test` |
| 4. Cluster (optional) | `oc diff -k` | Was sich am Cluster ändern würde, Server-Validierung | `diff` |

Stufe 2 und 3 laufen auf den **gerenderten** Overlays in `build/`, nicht auf der Base –
so werden auch Patches und Image-Pins geprüft.

## Ausführen
```bash
make check                                    # Stufe 1–3
make test SCHEMA_FLAGS=-ignore-missing-schemas  # offline, CRDs überspringen
make test K8S_VERSION=1.30.0                  # gegen andere Version (OpenShift 4.17)
make diff ENV=prod                            # benötigt oc login, nur lesend
```

## Regeln
- Neues Overlay oder neue Ressource ⇒ `make check` muss für **alle** Overlays grün sein.
- kube-linter-Ausnahmen nur per Annotation am Objekt, mit Begründung und ggf. ADR.
- `oc diff` vor jedem Merge in einen Umgebungs-Overlay; Ergebnis im Merge Request erwähnen.
