# 0002: Kustomize und GitOps statt Helm und manuellem Apply

- **Status:** Akzeptiert
- **Datum:** 2026-10-13

## Kontext
Manifeste für mehrere Umgebungen sollen nachvollziehbar, reviewbar und ohne Templating-Logik gepflegt werden.

## Entscheidung
Kustomize mit `base/` und `overlays/<env>/`. Ausgerollt wird per GitOps (OpenShift GitOps/Argo CD)
aus dem jeweiligen Overlay, nicht per `oc apply` von Hand.

## Alternativen
- **Helm:** mächtiger, aber Go-Templates erschweren Review und Linting der Ausgabe.
- **OpenShift Templates:** OpenShift-spezifisch, weniger Werkzeugunterstützung.

## Konsequenzen
- `oc kustomize` reicht als Werkzeug, kein zusätzlicher Client nötig.
- Der Agent darf keine schreibenden `oc`-Befehle ausführen.
