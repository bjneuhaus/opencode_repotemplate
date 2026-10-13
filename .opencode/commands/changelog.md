---
description: CHANGELOG-Einträge aus den letzten Commits vorschlagen
---

Commits seit dem letzten Tag:
!`git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --oneline`

Ergänze @CHANGELOG.md unter `[Unreleased]`:
- `feat:` → Added, `fix:` → Fixed, Verhaltensänderung → Changed
- `docs:`, `test:`, `chore:` nur, wenn für Nutzer relevant
- Aus Nutzersicht formulieren, nicht als Commit-Text
