---
description: Lint und Tests ausführen (make check) und Fehler erklären
---

<!--
  Gemeinsam für alle Flavors, weil jeder Flavor `make check` bereitstellt.
  !`befehl` fügt Shell-Ausgabe ein, $ARGUMENTS den Text nach /check.
-->

Ergebnis von `make check`:
!`make check 2>&1 | tail -n 60`

Fasse zusammen, was fehlschlägt, erkläre jeweils kurz die Ursache und schlage eine
Korrektur vor. Zusätzlicher Fokus (falls angegeben): $ARGUMENTS
Wenn alles grün ist, sag das in einem Satz.
