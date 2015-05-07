# Grundlagen

* Decompiler-Framework
  * erweiterbar
  * lesbar
  * frei

# Design
* Designentscheidungen
  * OOP
  * Schwerpunkt auf Design
    * Mudularisierung
  * Python

# Problematik
* Problematik
  * moderne Software immer komplexer
  * kompilierter Code höchstens disassembliert verfügbar
  * enormer Aufwand bei der Analyse
    * Schadprogramme etc.
    * eigene, alte Projekte
  * Reverse-Engineering Grundlagen
    * Instruktionen und Assembler
    * Funktionen und Stackframes
  * (De)compiler und Disassembler
    * Probleme und Eigenheiten

## Folgen für das Projekt
* Folgen für das Projekt
  * kein Decompiler
  * Graph-basierte Analyse (Structural Analysis)
  * Heuristiken zu optimisierten Integer-Divisionen und Daten auf dem Stack

# Ausblick
* Ausblick
  * Stabilisierung
  * Dokumentation
  * Restrukturierungen
  * neue Features (für CFG) und Frontends
