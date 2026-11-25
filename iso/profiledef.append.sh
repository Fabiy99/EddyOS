
# --- EddyOS ---------------------------------------------------------------
# Wird von iso/build.sh an das profiledef.sh von releng angehängt.
# Spätere Zuweisungen überschreiben die von releng.
iso_name="eddyos"
iso_label="EDDYOS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="EddyOS <https://github.com/Fabiy99/EddyOS>"
iso_application="EddyOS Live"
file_permissions+=(
  ["/etc/sudoers.d/eddy-live"]="0:0:440"
)
