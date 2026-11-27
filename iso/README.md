# ISO-Profil

EddyOS baut seine Live-ISO mit [archiso](https://wiki.archlinux.org/title/Archiso). Statt ein
komplettes Profil zu kopieren, nimmt `build.sh` das offizielle Profil `releng` und legt nur die
EddyOS-Änderungen darüber. Neue archiso-Versionen kommen so automatisch mit.

| Datei | Zweck |
| --- | --- |
| `build.sh` | Setzt das Profil zusammen und ruft `mkarchiso` auf |
| `packages.x86_64` | Pakete zusätzlich zu releng (Plasma, Programme, Treiber) |
| `profiledef.append.sh` | Name, Label und Dateirechte der ISO |
| `airootfs/` | Dateien, die so ins Live-System kommen |
| `users/*.append` | Live-Benutzer `eddy` ohne Passwort, mit sudo |
| `keyring/` | CachyOS-Schlüssel für den Build-Rechner |

## Was die ISO kann (in einer VM getestet, noch nicht auf echter Hardware)

- Startet per UEFI und altem BIOS direkt in KDE Plasma 6 (Wayland), angemeldet als `eddy`.
- Deutsch als Sprache und Tastatur, alle anderen Sprachen sind vorhanden.
- CachyOS-Kernel (`linux-cachyos`) aus dem allgemeinen CachyOS-Repo, läuft auf jeder 64-Bit-CPU.
- Firefox, Dolphin, Konsole, NetworkManager, PipeWire.

Noch nicht dabei: Installer, CPU-optimierte Repos, EddyOS-Design. Siehe [Roadmap](../docs/de/roadmap.md).

## Selbst bauen

Auf einem Arch-System (oder in einem Arch-Container mit `--privileged`):

```bash
sudo pacman -S archiso
sudo ./iso/build.sh
```

Die ISO landet in `out/`. Zum Testen ohne USB-Stick:

```bash
run_archiso -u -i out/eddyos-*.iso
```
