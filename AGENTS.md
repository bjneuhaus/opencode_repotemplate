<!--
  TEMPLATE (YAML-Flavor): Wird bei jeder OpenCode-Session automatisch geladen.
  Kurz halten, Details in docs/. Hello-Beispiel durch eigene Anwendung ersetzen.
-->

# AGENTS.md – hello (OpenShift / Kubernetes)

## Projekt in einem Satz
Kustomize-Manifeste für eine statische Hello-World-Webseite auf OpenShift (httpd, Route, NetworkPolicy).

## Befehle
```bash
make render        # Overlays nach build/<env>.yaml rendern
make lint          # yamllint + kube-linter
make fmt           # yamlfmt
make test          # kubeconform: Schema-Validierung (strict)
make check         # lint + test – muss vor jedem Commit grün sein
make diff ENV=dev  # oc diff gegen den Cluster (nur lesend)
oc kustomize deploy/overlays/dev   # einzelnes Overlay ansehen
```
Werkzeuge: `oc`, `yamllint`, `kube-linter`, `kubeconform`, `yamlfmt`. Ziel: OpenShift 4.16 (Kubernetes 1.29).

## Struktur
- `deploy/base/` – umgebungsneutrale Manifeste, eine Ressource pro Datei, ohne Namespace und Image-Tag
- `deploy/overlays/<env>/` – Namespace, Replicas, Image-Pin, Ressourcen-Patches pro Umgebung
- `build/` – gerenderte Ausgabe, wird nicht committet
- `.yamllint.yaml`, `.kube-linter.yaml`, `.yamlfmt` – Linter- und Formatter-Config

## Wichtige Regeln
- Jede Workload hat: Requests/Limits, Readiness- und Liveness-Probe, `runAsNonRoot`,
  `allowPrivilegeEscalation: false`, `capabilities.drop: [ALL]`, `seccompProfile: RuntimeDefault`.
- Kein `runAsUser`/`fsGroup` – OpenShift vergibt UIDs über die SCC `restricted-v2`.
- Images immer gepinnt (Tag, in prod Digest) – nie `:latest`.
- Labels nach `app.kubernetes.io/*`; Selektoren nur auf `app.kubernetes.io/name`.
- Jede Workload ist durch eine NetworkPolicy abgedeckt.
- Änderungen nur über Kustomize (Base + Patches), keine Kopien von Manifesten in Overlays.
- Nach jeder Änderung `make check`.

## Nicht tun
- **Niemals** `oc apply`, `oc delete`, `oc patch`, `oc scale` o.ä. gegen einen Cluster ausführen.
  Erlaubt sind nur lesende Befehle (`oc get`, `oc describe`, `oc diff`, `oc kustomize`).
  Deployments laufen über GitOps/CI.
- Keine `Secret`-Manifeste mit echten Werten – nur SealedSecrets/ExternalSecrets oder Platzhalter.
- Keine cluster-weiten Ressourcen (ClusterRole, SCC, CRDs, Namespaces) ohne Rückfrage.
- Keine kube-linter-Ausnahme ohne `ignore-check.kube-linter.io/<check>`-Annotation mit Begründung.

## Weiterführende Doku (bei Bedarf lesen)
- Architektur: @docs/architecture.md
- Validierung und Tests: @docs/testing.md
- Entscheidungen: @docs/decisions/
- Konventionen (immer geladen via opencode.json): docs/conventions.md
