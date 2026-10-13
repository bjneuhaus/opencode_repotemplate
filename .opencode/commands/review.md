---
description: Review der aktuellen Änderungen durch den Reviewer-Agent
agent: reviewer
subtask: true
---

<!-- Aufruf: /review oder /review <Fokus>, z.B. "/review Sicherheit" -->

Reviewe die aktuellen Änderungen in diesem Branch.

Geänderte Dateien:
!`git diff --stat main...HEAD 2>/dev/null || git diff --stat`

Besonderer Fokus (falls angegeben): $ARGUMENTS
