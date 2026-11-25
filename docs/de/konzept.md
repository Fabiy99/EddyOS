# EddyOS: Konzept

Stand: 25.11.2026. Diese Datei hält fest, was beschlossen ist und warum. Was noch fehlt, steht in
der [Roadmap](roadmap.md).

## Ziel

Eine eigenständige Distribution auf Arch-Basis. Leistung und Gaming wie bei CachyOS, Bedienung
und Komfort wie unter Windows, aber ein eigenes Design statt Windows-Optik. Niemand soll für
alltägliche Dinge ein Terminal brauchen.

## Zielgruppen

| Gruppe | Was sie braucht |
| --- | --- |
| Gaming-PC | Optimierter Kernel und Pakete, Treiber automatisch, HDR und VRR, alle Spieleplattformen |
| Alter Mini-PC | Retro-Konsole fürs Wohnzimmer, altes BIOS, ältere CPUs, wenig RAM |
| Handheld | Steam Deck (LCD, OLED), ROG Ally/Ally X, Legion Go/Go S, MSI Claw, GPD, Ayaneo |
| Umsteiger von Windows | Daten und Spiele mitnehmen, `.exe` starten, vertraute Bedienung |

## Grundsatzentscheidungen

| Thema | Entscheidung | Begründung |
| --- | --- | --- |
| Basis | Arch Linux, dazu die Repos und Kernel von CachyOS | Spart Monate Arbeit. Oberfläche, Installer und Apps sind eigene, also kein Fork. |
| Pakete | Automatische Wahl: x86-64-v3/v4/Zen 4 auf neuen CPUs, normale Pakete auf alten | Alte Celeron/Atom-Mini-PCs können die optimierten Pakete nicht ausführen. |
| Kernel | CachyOS-Kernel mit BORE und sched-ext | Flüssigeres Spielen, Kernel-Manager in den Einstellungen |
| Desktop-Unterbau | KDE Plasma 6 mit eigenem Design | Beide Vorbilder nutzen Plasma; eine eigene Oberfläche von null wäre zu viel. |
| Konsolenmodus | Eigene Oberfläche „Eddy Play“ auf gamescope | HDR, VRR, HDMI 2.1, Steam eingebettet |
| Dateisystem | btrfs mit snapper | Wiederherstellungspunkte vor jedem Update, wählbar im Bootmenü |
| Bootloader | Limine | Startet mit UEFI und altem BIOS, zeigt Snapshots im Bootmenü |
| Secure Boot | shim mit EddyOS-Schlüssel (MOK), später eigener Microsoft-signierter shim über shim-review | Wichtig für Anti-Cheat; shim-review dauert Monate |
| Installer | Calamares mit eigenem QML-Design und eigenen Modulen, Vollbild direkt vom USB-Stick | Partitionieren, Dual-Boot und Verschlüsselung sind dort fertig |
| Retro | Unsichtbare libretro-Kerne, nur bei Bedarf geladen, Controller automatisch passend belegt | Ein „ROM-Compiler“ für alle Konsolen ist nicht machbar; so fühlt es sich trotzdem nativ an |
| KI-Assistent | Lokal per Standard, Cloud nur mit eigenem Schlüssel, schlägt nur vor, Snapshot vor jeder Änderung | Datenschutz und Vertrauen |
| Lizenz | GPLv3 für Code, CC BY-SA 4.0 für Grafiken, Name und Logo als Marke vorbehalten | Wie bei Fedora und Firefox |

## Funktionen

### Installation und Umstieg
- USB-Stick startet direkt in einen Vollbild-Installer: „EddyOS installieren“ oder „Erst ausprobieren“ (Live-System mit Hardware-Check).
- Schritte: Sprache, Nutzungsart (Desktop oder Konsole), Festplatte, Windows-Daten, Assistent ja/nein, Konto.
- Mit Controller und Touch bedienbar, offline installierbar, Festplattenverschlüsselung mit optionaler TPM-Entsperrung.
- Umzugshelfer: Dokumente, Bilder, Lesezeichen, WLAN-Netzwerke von der Windows-Partition; vorhandene Steam- und Epic-Spiele werden übernommen, ohne sie neu zu laden.

### Desktop
- Eigene Taskleiste mit Startmenü, Suche, Assistent-Knopf, angehefteten Apps und Infobereich.
- Fenster einrasten mit Layout-Auswahl über dem Maximieren-Knopf.
- App-Center mit Ein-Klick-Installation und Deinstallations-Übersicht.
- Datei-Explorer mit „Mein Gerät“, Laufwerken und Füllstand; USB-Sticks werden automatisch eingebunden und fragen „Was möchtest du tun?“.
- `.exe` per Doppelklick: Installation in eine eigene, geschützte Umgebung mit Startmenü-Eintrag.
- Einstellungen ohne Terminal: Modus, Sprache, Updates, Treiber, Gaming, Assistent, Datenschutz, Sicherung.
- Mehrsprachig über die normalen Linux-Übersetzungen.

### Gaming
- Steam, Epic und GOG (über Heroic) in einer Bibliothek.
- „Läuft das?“-Ampel für Spiele und Windows-Programme, inklusive Anti-Cheat-Hinweis.
- Proton automatisch, Shader vorladen, gamemode, MangoHud, vkBasalt, OBS-Spielaufnahme.
- Anti-Cheat-Check (Secure Boot, TPM und weitere Voraussetzungen).
- Clip der letzten 30 Sekunden und Screenshots per Taste.

### Retro
- ROMs per USB-Stick oder Netzwerkordner; sie erscheinen in der Bibliothek und starten wie jedes andere Spiel.
- Cover, Beschreibungen und Videos automatisch, RetroAchievements.
- Couch-Koop: Controller werden automatisch Spieler 1 bis 4 zugeordnet.

### Konsole und Handheld
- Profile mit Kinderschutz (Spielzeit, Altersfreigaben).
- Streaming vom Gaming-PC im Heimnetz (Sunshine und Moonlight).
- Spielstände zwischen Geräten abgleichen.
- Schnellmenü im Spiel; auf Handhelds mit TDP, Lüfter, Ladegrenze, Bildwiederholrate.
- Bildschirmtastatur, Standby wie bei einer Konsole, nächtliche Updates.
- Fernseher und Controller erkannt: Konsolenmodus anbieten.
- Handy als Fernbedienung über KDE Connect.

### Hilfe, Sicherheit, Daten
- Knopf „Etwas funktioniert nicht“, angetrieben vom Assistenten, mit Rücknahme des letzten Updates.
- Keine Telemetrie; Übersicht, welche App ins Internet geht.
- Automatische Sicherung auf externe Platte oder NAS.
- Fernhilfe mit Zustimmung, Barrierefreiheit, Laptop-Ladegrenze.

## Bekannte Grenzen

- Spiele mit Kernel-Anti-Cheat, die Linux sperren, laufen auf keiner Distribution. Die Ampel warnt vor dem Kauf.
- Auf dem Steam Deck lässt sich Secure Boot nicht nutzen; Spiele, die es verlangen, laufen dort nicht.
- ARM-Geräte wie der Raspberry Pi kommen frühestens am Ende der Roadmap.

## Vorbilder

- [CachyOS](https://cachyos.org): Kernel, optimierte Pakete, Hardware-Erkennung (`chwd`).
- [Bazzite](https://github.com/ublue-os/bazzite): Gaming-Modus, Handheld-Unterstützung, Anti-Cheat-Check.
- [Batocera](https://batocera.org): Retro-Konsole, die einfach funktioniert.
