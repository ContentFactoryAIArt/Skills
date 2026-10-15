# Mit ContentFactory starten

Erstelle Videos, Bilder, Sprachaufnahmen, Musik und bearbeitbare Kompositionen mit ContentFactory und deinem KI-Agenten. Die Anweisungen des Skills sind auf Englisch; du kannst auf Deutsch arbeiten und deutsche Inhalte erstellen.

## In vier Schritten loslegen

1. Installiere Python 3.11 oder neuer und die aktuelle Codex CLI. Wähle einen bereits vorhandenen Projektordner.
2. [Lade dieses Repository als ZIP herunter](https://github.com/ContentFactoryAIArt/Skills/archive/refs/heads/main.zip) und entpacke es, oder führe Folgendes aus:

   ```sh
   git clone https://github.com/ContentFactoryAIArt/Skills.git
   cd Skills
   ```

3. Starte im entpackten oder geklonten Repositoryordner den Einrichtungsassistenten mit dem Pfad zu deinem vorhandenen Projektordner:

   ```powershell
   python scripts/connect.py --workspace "C:\Projects\MyVideo"
   ```

   Unter macOS oder Linux verwende `python3` und einen vorhandenen Pfad wie `~/projects/my-video`. Melde dich im Browser bei ContentFactory an und wähle Projekte, Berechtigungen und Zugriffsdauer.

4. Öffne das Projekt in Codex oder lade es neu und schreibe:

   > Erstelle mit $contentfactory-video ein 30 Sekunden langes Produktvideo auf Deutsch. Arbeite in meinem ausgewählten Projekt und zeige vor kostenpflichtigen Vorgängen den Plan und die voraussichtlichen Kosten.

## Andere MCP-Clients

Wenn dein Client Remote-MCP über Streamable HTTP mit OAuth unterstützt, füge `https://content-factory.art/mcp` als einen Server hinzu und autorisiere ihn im Browser. Installiere anschließend den gesamten Ordner `skills/contentfactory-video` mit der Skill-Funktion des Clients.

## Probleme mit der Verbindung?

Wenn der Assistent meldet, dass der einheitliche Endpunkt nicht verfügbar ist, wird die passende ContentFactory-Serverversion benötigt. `--install-only` bereitet nur den Skill vor; zum Erstellen ist eine aktive Verbindung erforderlich. Bei einer funktionierenden Verbindung ist keine erneute Anmeldung nötig.

Weitere Hilfe bietet die [ausführliche englische Anleitung](en.md).

## Fotos, Video und 3D mit Claude Code

ContentFactory ist ein kostenloser Browser-Editor für Fotos, Video und 3D. Dein eigener Agent kann auch komplette Videos erstellen. Generierung und KI-Analyse können kostenpflichtig sein.

Installiere die aktuelle Claude Code CLI. Diese Alternative richtet den Skill und einen einzigen MCP-Zugang ein. Schließe die Anmeldung im Browser ab und verwende /contentfactory-video. Pro Client ist eine ContentFactory-Autorisierung nötig; bestehende Verbindungen werden wiederverwendet.

```powershell
python scripts/connect.py --client claude --workspace "C:\Projects\MyVideo"
```
