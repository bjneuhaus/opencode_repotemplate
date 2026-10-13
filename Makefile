# YAML-Flavor (OpenShift/Kubernetes) – einheitliche Ziele: lint | fmt | test | check
# Benötigt: yamllint, kube-linter, kubeconform, yamlfmt und oc (oder kubectl/kustomize)
#
# OpenShift ↔ Kubernetes: 4.14=1.27, 4.15=1.28, 4.16=1.29, 4.17=1.30, 4.18=1.31

KUSTOMIZE   ?= oc kustomize        # Alternativen: kubectl kustomize | kustomize build
K8S_VERSION ?= 1.29.0
ENV         ?= dev
BUILD_DIR   := build
OVERLAYS    := $(notdir $(wildcard deploy/overlays/*))

# Route & Co. sind CRDs – Schemas aus dem CRDs-Catalog. Offline: SCHEMA_FLAGS=-ignore-missing-schemas
SCHEMA_FLAGS ?= -schema-location default \
  -schema-location 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json'

.PHONY: help render lint fmt test check diff clean

help:
	@echo "render  Overlays nach $(BUILD_DIR)/<env>.yaml rendern"
	@echo "lint    yamllint + kube-linter (auf gerenderten Manifesten)"
	@echo "fmt     yamlfmt"
	@echo "test    Schema-Validierung mit kubeconform (strict)"
	@echo "check   lint + test"
	@echo "diff    oc diff gegen den Cluster (ENV=$(ENV)), read-only"

render:
	@mkdir -p $(BUILD_DIR)
	@for o in $(OVERLAYS); do \
	  echo "render $$o"; \
	  $(KUSTOMIZE) deploy/overlays/$$o > $(BUILD_DIR)/$$o.yaml || exit 1; \
	done

lint: render
	yamllint .
	kube-linter lint --config .kube-linter.yaml $(BUILD_DIR)

fmt:
	yamlfmt .

test: render
	kubeconform -strict -summary -kubernetes-version $(K8S_VERSION) $(SCHEMA_FLAGS) $(BUILD_DIR)/*.yaml

check: lint test

diff:
	oc diff -k deploy/overlays/$(ENV)

clean:
	rm -rf $(BUILD_DIR)
