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

echo ":: CachyOS-Schlüssel auf dem Build-Rechner einrichten"
# pacman prüft beim Bau jedes Paket mit dem Schlüsselbund des Build-Rechners.
(cd "$here/keyring" && sha512sum --quiet -c SHA512SUMS)
install -Dm644 -t /usr/share/pacman/keyrings/ \
  "$here/keyring/cachyos.gpg" "$here/keyring/cachyos-trusted" "$here/keyring/cachyos-revoked"
[[ -d /etc/pacman.d/gnupg ]] || pacman-key --init
pacman-key --populate cachyos

rm -rf "$work"
mkdir -p "$work" "$out"
profile="$work/profile"
cp -a "$releng" "$profile"

echo ":: CachyOS-Repo eintragen"
# Das allgemeine x86-64-Repo läuft auf jeder 64-Bit-CPU, auch auf alten Mini-PCs.
# Die optimierten Repos (v3, v4, Zen 4) wählt später der Installer passend zur CPU.
sed -i '/^\[core\]/i [cachyos]\nServer = https://mirror.cachyos.org/repo/$arch/$repo\n' \
  "$profile/pacman.conf"
grep -q '^\[cachyos\]' "$profile/pacman.conf"

echo ":: CachyOS-Kernel statt Arch-Kernel"
sed -i '/^linux$/d' "$profile/packages.x86_64"
grep -rlE 'vmlinuz-linux|initramfs-linux' "$profile/grub" "$profile/syslinux" "$profile/efiboot" \
  | xargs sed -i -E 's/vmlinuz-linux\b/vmlinuz-linux-cachyos/g; s/initramfs-linux(-fallback)?\.img/initramfs-linux-cachyos\1.img/g'
presets="$profile/airootfs/etc/mkinitcpio.d"
if [[ -f $presets/linux.preset ]]; then
  sed -E 's/vmlinuz-linux\b/vmlinuz-linux-cachyos/g; s/initramfs-linux(-fallback)?\.img/initramfs-linux-cachyos\1.img/g' \
    "$presets/linux.preset" > "$presets/linux-cachyos.preset"
  rm "$presets/linux.preset"
fi

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
