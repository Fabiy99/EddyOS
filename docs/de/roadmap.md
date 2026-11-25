# EddyOS: Roadmap

Die Etappen bauen aufeinander auf. Jede endet mit einer ISO, die man ausprobieren kann.
Was beschlossen ist und warum, steht im [Konzept](konzept.md).

## Etappe 0: Grundlage ← wir sind hier

- [x] Repo mit Lizenz, Konzept und Roadmap
- [x] Klickbare Vorschau der Oberfläche
- [x] archiso-Profil: Live-ISO startet KDE Plasma 6 mit EddyOS-Namen
- [x] GitHub Actions baut die ISO bei jedem Push, Releases über Tags
- [x] Erster ISO-Bau erfolgreich (25.11.2026, 2,1 GB)
- [x] ISO in einer VM getestet (25.11.2026)
- [ ] ISO auf echter Hardware getestet
- [ ] GitHub Pages eingeschaltet, Website erreichbar

## Etappe 1: Installierbares Grundsystem

- [ ] CachyOS-Repos und -Kernel, automatische Paketwahl je nach CPU
- [ ] Calamares mit EddyOS-Design, zunächst die Standardschritte
- [ ] btrfs mit snapper, Limine mit Snapshots im Bootmenü, UEFI und BIOS
- [ ] Hardware-Erkennung für Grafiktreiber (NVIDIA offen oder proprietär, Hybrid-Laptops)
- [ ] Deutsch und Englisch vollständig
- [ ] Eigenes Paket-Repo für EddyOS-Pakete, signiert, gebaut über GitHub Actions

## Etappe 2: Eddy Desktop

- [ ] Plasma-Design: Farben, Taskleiste, Startmenü, Fenster einrasten, Symbole
- [ ] App-Center mit Ein-Klick-Installation und Deinstallations-Übersicht
- [ ] Datei-Explorer mit „Mein Gerät“, USB-Fenster „Was möchtest du tun?“
- [ ] Einstellungen: Modus, Updates mit Wiederherstellungspunkt, Treiber
- [ ] Vollbild-Installer mit „Installieren“ und „Erst ausprobieren“

## Etappe 3: Gaming

- [ ] Steam, Heroic, Proton-Auswahl, gamemode, MangoHud, vkBasalt, OBS VkCapture
- [ ] Gaming-Einstellungen ohne Terminal
- [ ] „Läuft das?“-Ampel, erste Version
- [ ] Anti-Cheat-Check
- [ ] Secure Boot mit shim und EddyOS-Schlüssel
- [ ] Zusatztreiber: Xbox-Funkadapter, Lenkräder, Razer, Tabletts, Capture-Karten

## Etappe 4: Eddy Play

- [ ] Konsolenoberfläche auf gamescope, Bibliothek für Steam, Epic, GOG und Retro
- [ ] Retro-Kerne unsichtbar und bei Bedarf, automatische Controller-Belegung
- [ ] Cover-Scraping, RetroAchievements, Couch-Koop
- [ ] Schnellmenü im Spiel, Moduswechsel Desktop und Konsole
- [ ] Profile und Kinderschutz

## Etappe 5: Handhelds und alte Hardware

- [ ] Geräteerkennung für Steam Deck, ROG Ally, Legion Go, MSI Claw
- [ ] TDP, Lüfter, Ladegrenze, Gyro, Rücktasten (InputPlumber oder Handheld Daemon)
- [ ] Bildschirmtastatur, zuverlässiger Standby, Touch im Installer
- [ ] Schlankes Konsolenprofil für schwache Mini-PCs, Hardware-Check zeigt flüssige Retro-Systeme

## Etappe 6: Komfort und KI

- [ ] Umzugshelfer von Windows
- [ ] `.exe` per Doppelklick in geschützter Umgebung
- [ ] EddyOS-Assistent, lokal, mit Knopf „Etwas funktioniert nicht“
- [ ] Streaming vom Gaming-PC, Spielstand-Sync, automatische Sicherung
- [ ] Datenschutz-Übersicht, Fernhilfe, Barrierefreiheit, KDE Connect als Fernbedienung
- [ ] Fernseher und Controller erkannt: Konsolenmodus anbieten, Ruhemodus mit nächtlichen Updates

## Etappe 7: Projekt und Dauerbetrieb

- [ ] Website mit Download und Handbuch auf Deutsch und Englisch
- [ ] Community (GitHub Discussions oder Discord), Liste getesteter Geräte
- [ ] Update-Kanäle „Stabil“ und „Test“
- [ ] Sicherheitsprozess und shim-review für einen Microsoft-signierten shim
- [ ] Markenprüfung für Name und Logo, Spenden für Server
- [ ] Später: ARM und Raspberry Pi
