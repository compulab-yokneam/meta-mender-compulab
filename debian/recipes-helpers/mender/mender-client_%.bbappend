RDEPENDS:${PN}:remove:mender-growfs-data:mender-systemd = "util-linux-fdisk"
RDEPENDS:${PN}:append:mender-growfs-data:mender-systemd = " fdisk "

require mender-data.inc
