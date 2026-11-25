<p align="center"><img src="website/logo.svg" width="96" alt=""></p>

# EddyOS

**[Deutsch](#deutsch) | [English](#english)**

---

## Deutsch

EddyOS ist eine Linux-Distribution auf Basis von Arch Linux. Sie soll so schnell sein wie
CachyOS, beim Spielen so bequem wie eine Konsole und im Alltag so einfach wie Windows, aber mit
eigenem Design und ohne dass man jemals ein Terminal öffnen muss.

> **Stand:** Konzeptphase. Die Live-ISO startet bereits einen KDE-Plasma-Desktop, alle
> EddyOS-eigenen Funktionen sind noch in Arbeit. Siehe [Roadmap](docs/de/roadmap.md).

**Vorschau der Oberfläche:** [website/vorschau.html](website/vorschau.html), nach dem
Einschalten von GitHub Pages auch unter `https://fabiy99.github.io/EddyOS/vorschau.html`.

### Für wen

- **Gaming-PCs:** optimierter Kernel und Pakete, Steam, Epic und GOG in einer Bibliothek, Treiber automatisch.
- **Alte Mini-PCs als Retro-Konsole:** startet auch mit altem BIOS und älteren CPUs, schlankes Konsolenprofil.
- **Handhelds:** Steam Deck, ROG Ally, Legion Go, MSI Claw und weitere.
- **Umsteiger von Windows:** Daten und Spiele werden übernommen, `.exe`-Dateien starten per Doppelklick.

### Zwei Gesichter

- **Eddy Desktop:** KDE Plasma 6 mit eigenem Design, Taskleiste, Fenster einrasten, App-Center,
  Datei-Explorer mit „Mein Gerät“, USB-Fenster „Was möchtest du tun?“.
- **Eddy Play:** Vollbild-Konsolenoberfläche auf gamescope, komplett mit dem Controller bedienbar,
  PC-Spiele und Retro-Spiele in einer Bibliothek.

Was es wird, entscheidet man bei der Installation. Umstellen geht später jederzeit in den Einstellungen.

### Aufbau des Repos

| Ordner | Inhalt |
| --- | --- |
| `docs/de/` | [Konzept](docs/de/konzept.md) und [Roadmap](docs/de/roadmap.md) |
| `iso/` | archiso-Profil für die Live-ISO, siehe [iso/README.md](iso/README.md) |
| `website/` | Projektseite und klickbare Vorschau für GitHub Pages |
| `.github/workflows/` | Automatischer ISO-Bau und Veröffentlichung der Website |

### ISO bauen

Jeder Push auf `main` baut die ISO automatisch mit GitHub Actions. Die fertige Datei hängt
unter **Actions → ISO bauen → Artifacts**. Ein Tag wie `v0.1.0` erzeugt zusätzlich ein Release.
Lokal geht es auf einem Arch-System mit `sudo ./iso/build.sh`.

### Lizenz

Der Code steht unter der [GNU GPL v3](LICENSE). Name und Logo „EddyOS“ sind davon ausgenommen:
Veränderte Versionen dürfen gern verteilt werden, aber nicht unter dem Namen EddyOS.

---

## English

EddyOS is an Arch-based Linux distribution that aims to be as fast as CachyOS, as easy to game on
as a console and as simple to use as Windows, with its own design and no terminal required.

> **Status:** concept phase. The live ISO already boots a KDE Plasma desktop; all EddyOS-specific
> features are still being built. See the [roadmap](docs/de/roadmap.md) (German).

It targets gaming PCs, old mini PCs used as retro consoles, handhelds such as the Steam Deck, and
people moving over from Windows. At install time you choose **Eddy Desktop** (KDE Plasma 6 with a
custom design) or **Eddy Play** (a full-screen, controller-driven console interface on gamescope),
and you can switch later in Settings.

Every push to `main` builds the ISO with GitHub Actions; tags like `v0.1.0` create a release.

Code is licensed under the [GNU GPL v3](LICENSE). The name and logo "EddyOS" are not covered by
that licence: modified versions are welcome, but not under the EddyOS name.
