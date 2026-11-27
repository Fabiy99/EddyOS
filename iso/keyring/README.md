# CachyOS-Schlüssel

Unveränderte Kopie aus dem Paket `cachyos-keyring`
(<https://github.com/CachyOS/CachyOS-PKGBUILDS/tree/master/cachyos-keyring>, GPL-3.0-or-later).

`build.sh` braucht den Schlüssel auf dem Build-Rechner, damit pacman die Pakete aus dem
CachyOS-Repo prüfen kann, bevor `cachyos-keyring` selbst installiert ist. Fingerabdruck:
`882D CFE4 8E20 51D4 8E25 62AB F3B6 0748 8DB3 5A47`.

Die SHA-512-Summen in `SHA512SUMS` stimmen mit dem PKGBUILD überein. Bei einem neuen
Schlüssel beide Dateien zusammen aktualisieren.
