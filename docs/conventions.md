<!-- TEMPLATE (YAML): Immer geladen – kompakt halten. -->

# Konventionen (OpenShift / Kubernetes YAML)

## Dateien und Formatierung
- Eine Ressource pro Datei, Dateiname = `<kind-kurz>.yaml` (`deployment.yaml`, `route.yaml`).
  Mehrere gleiche Kinds: `<name>-<kind>.yaml`.
- Jede Datei beginnt mit `---`, 2 Spaces, Listen eingerückt, Zeilen ≤ 120 Zeichen.
- Nur `true`/`false` als Booleans (kein `yes`/`on`). Strings, die wie Zahlen aussehen, quoten: `newTag: "1.24"`.
- Feldreihenfolge: `apiVersion`, `kind`, `metadata`, `spec`.

## Labels
| Label | Inhalt | Beispiel |
|---|---|---|
| `app.kubernetes.io/name` | Anwendung (auch Selektor) | `hello` |
| `app.kubernetes.io/component` | Rolle | `web`, `db` |
| `app.kubernetes.io/part-of` | übergeordnetes System (Base) | `hello` |
| `app.kubernetes.io/instance` | Instanz/Umgebung (Overlay) | `hello-dev` |
| `app.kubernetes.io/managed-by` | Werkzeug | `kustomize` |

Selektoren (`matchLabels`, Service `selector`) nur auf `app.kubernetes.io/name` – Selektoren
sind bei Deployments unveränderlich.

## Pflicht für jeden Container
```yaml
resources:
  requests:          # immer
    cpu: 10m
    memory: 64Mi
  limits:            # immer, memory-Limit ≥ Request
    cpu: 200m
    memory: 128Mi
readinessProbe: {}   # immer
livenessProbe: {}    # immer, großzügiger als readiness
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
```
Auf Pod-Ebene: `runAsNonRoot: true`, `seccompProfile.type: RuntimeDefault`,
`automountServiceAccountToken: false` (außer der Pod braucht API-Zugriff).
`readOnlyRootFilesystem: true`, wenn das Image es erlaubt – sonst Ausnahme mit Begründung.

## Muster
```yaml
# Gut: gepinnt, über Overlay gesetzt
images:
  - name: hello-web
    newName: registry.access.redhat.com/ubi9/httpd-24
    digest: sha256:...

# Schlecht: direkt in der Base, veränderlich
image: registry.access.redhat.com/ubi9/httpd-24:latest
```

## Kustomize
- Kein `commonLabels` (veraltet, ändert Selektoren) – stattdessen `labels:` mit `includeTemplates: true`.
- Patches als eigene Datei (`patch-<zweck>.yaml`), nicht inline.
- ConfigMaps/Secrets aus Dateien über `configMapGenerator`/`secretGenerator`.
