#!/usr/bin/env bash
# Baut die EddyOS-Live-ISO.
# Grundlage ist das offizielle archiso-Profil "releng"; darüber kommen die
# EddyOS-Anpassungen aus diesem Ordner. So bleiben wir nah an Arch und müssen
# nur pflegen, was wirklich anders ist.
#
# Aufruf auf einem Arch-System:  sudo ./iso/build.sh
# Ergebnis:                      out/eddyos-JJJJ.MM.TT-x86_64.iso
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root="$(dirname "$here")"
work="${WORK_DIR:-$root/work}"
out="${OUT_DIR:-$root/out}"
releng="/usr/share/archiso/configs/releng"

if [[ $EUID -ne 0 ]]; then
  echo "Bitte mit sudo starten: sudo $0" >&2
  exit 1
fi
if [[ ! -d $releng ]]; then
  echo "archiso ist nicht installiert. Erst: pacman -S archiso" >&2
  exit 1
fi

rm -rf "$work"
mkdir -p "$work" "$out"
profile="$work/profile"
cp -a "$releng" "$profile"

echo ":: Rettungswerkzeuge aus releng entfernen"
# releng ist eine Rettungs-ISO. Diese Werkzeuge braucht ein Desktop-Live-System nicht,
# und ohne sie bleibt die ISO unter der 2-GB-Grenze für GitHub-Releases.
sed -i -E '/^(bcachefs-tools|clonezilla|cloud-init|darkhttpd|ddrescue|fsarchiver|irssi|lftp|lynx|mc|nmap|openconnect|openvpn|partclone|partimage|pptpclient|testdisk|vpnc|wvdial|xl2tpd)$/d' \
  "$profile/packages.x86_64"

echo ":: Pakete ergänzen"
grep -vE '^\s*(#|$)' "$here/packages.x86_64" >> "$profile/packages.x86_64"

echo ":: Dienste aus releng entfernen, die wir nicht wollen"
# NetworkManager ersetzt systemd-networkd und iwd, SSH braucht ein Live-Desktop nicht,
# und angemeldet wird über SDDM statt automatisch als root auf tty1.
rm -f \
  "$profile/airootfs/etc/systemd/system/multi-user.target.wants/systemd-networkd.service" \
  "$profile/airootfs/etc/systemd/system/multi-user.target.wants/iwd.service" \
  "$profile/airootfs/etc/systemd/system/multi-user.target.wants/sshd.service" \
  "$profile/airootfs/etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service" \
  "$profile/airootfs/etc/systemd/system/sockets.target.wants/systemd-networkd.socket"
rm -rf "$profile/airootfs/etc/systemd/system/getty@tty1.service.d"
rm -rf "$profile/airootfs/etc/systemd/network"

echo ":: EddyOS-Dateien übernehmen"
cp -a "$here/airootfs/." "$profile/airootfs/"

echo ":: Live-Benutzer anlegen"
for f in passwd shadow group gshadow; do
  target="$profile/airootfs/etc/$f"
  if [[ ! -f $target ]]; then
    case $f in
      passwd)  echo 'root:x:0:0:root:/root:/usr/bin/zsh' > "$target" ;;
      shadow)  echo 'root::14871::::::' > "$target" ;;
      group)   echo 'root:x:0:root' > "$target" ;;
      gshadow) echo 'root:!*::root' > "$target" ;;
    esac
  fi
  cat "$here/users/$f.append" >> "$target"
done

echo ":: Profil anpassen"
cat "$here/profiledef.append.sh" >> "$profile/profiledef.sh"

echo ":: ISO bauen (das dauert)"
mkarchiso -v -w "$work/build" -o "$out" "$profile"

echo ":: Fertig:"
ls -lh "$out"/*.iso
