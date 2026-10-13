---
name: new-overlay
description: Legt eine neue Umgebung als Kustomize-Overlay unter deploy/overlays an (Namespace, Image-Pin, Replicas, Patches) und validiert sie. Verwenden, wenn eine neue Stage wie test, staging oder qa hinzukommt.
---

<!-- TEMPLATE (YAML): Namespaces und Registry an eigene Konventionen anpassen. -->

# Neues Overlay anlegen

1. Ordner `deploy/overlays/<env>/` anlegen. Vorlage: `deploy/overlays/dev/` (nicht-produktiv)
   oder `deploy/overlays/prod/` (produktiv, mit PDB und Digest).
2. `kustomization.yaml` mit:
   - `namespace: <app>-<env>`
   - `resources: [../../base]` (+ eigene Zusatzressourcen)
   - `labels` mit `app.kubernetes.io/instance: <app>-<env>` und `includeTemplates: true`
   - `images` mit gepinntem Tag bzw. Digest
   - bei Bedarf `replicas` und `patches` (eigene Dateien `patch-<zweck>.yaml`)
3. Keine Manifeste aus der Base kopieren – nur patchen.
4. `make check` – das neue Overlay wird automatisch gerendert und geprüft.
5. Kustomize-Diagramm in `docs/architecture.md` und Tree View in `README.md` ergänzen.
6. Namespace-Anlage und GitOps-Application gehören **nicht** in dieses Repo – im Merge Request darauf hinweisen.

## Vorlage
```yaml
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: hello-<env>

resources:
  - ../../base

labels:
  - pairs:
      app.kubernetes.io/instance: hello-<env>
    includeTemplates: true

images:
  - name: hello-web
    newName: registry.access.redhat.com/ubi9/httpd-24
    newTag: "<tag>"
```
