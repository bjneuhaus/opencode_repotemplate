<!-- TEMPLATE (YAML): Aufbau der Manifeste und Umgebungen anpassen. -->

# Architektur

## Laufzeit
```mermaid
flowchart LR
    C[Client] -->|HTTPS| R[Route hello<br/>TLS edge, Redirect]
    R --> RT[OpenShift Router]
    RT -->|NetworkPolicy erlaubt| S[Service hello :8080]
    S --> P1[Pod httpd]
    S --> P2[Pod httpd]
    CM[ConfigMap hello-content-hash] -.->|/var/www/html, read-only| P1
    CM -.-> P2
```

## Kustomize-Aufbau
```mermaid
flowchart TB
    B[deploy/base<br/>SA, Deployment, Service, Route, NetworkPolicy, ConfigMap]
    B --> D[overlays/dev<br/>ns hello-dev, 1 Replica, Image-Tag]
    B --> P[overlays/prod<br/>ns hello-prod, 2 Replicas, Digest, PDB, mehr Ressourcen]
```

## Ressourcen
| Datei | Zweck |
|---|---|
| `base/serviceaccount.yaml` | Eigene Identität, kein automatisch gemountetes Token |
| `base/deployment.yaml` | httpd-Container mit Probes, Limits, Security Context, Anti-Affinity |
| `base/service.yaml` | ClusterIP auf Port `http` (8080) |
| `base/route.yaml` | Externer Zugang, TLS am Router terminiert |
| `base/networkpolicy.yaml` | Nur Router darf auf die Pods zugreifen |
| `base/content/index.html` | Inhalt, per `configMapGenerator` mit Hash-Suffix |
| `overlays/prod/pdb.yaml` | Mindestens ein Pod bei Wartung verfügbar |
| `overlays/prod/patch-resources.yaml` | Höhere Requests/Limits in Produktion |

## Prinzipien
- **Base ist umgebungsneutral.** Alles, was sich pro Umgebung unterscheidet, gehört ins Overlay.
- **Git ist die Wahrheit.** Der Cluster wird per GitOps (z.B. OpenShift GitOps/Argo CD) aus `deploy/overlays/<env>` synchronisiert.
- **Konfigurationsänderung = Rollout.** ConfigMaps über Generatoren, damit sich der Name ändert.
