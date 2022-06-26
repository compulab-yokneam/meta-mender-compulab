# Make the mender-configure create a mender-configure-data package.
# This package will be used by Debian installer.

PACKAGES:append = " ${PN}-data "

FILES:${PN}:remove = " \
    ${datadir}/mender/modules/v3/mender-configure \
    ${datadir}/mender/inventory/mender-inventory-mender-configure \
    /var/lib/mender-configure \
    /data/mender-configure \
"

FILES:${PN}-demo:remove = " \
    /data/mender-configure/device-config.json \
"

FILES:${PN}-data = " \
    ${datadir}/mender/modules/v3/mender-configure \
    ${datadir}/mender/inventory/mender-inventory-mender-configure \
    /var/lib/mender-configure \
    /data/mender-configure \
    /data/mender-configure/device-config.json \
"

RDEPENDS:${PN}:append = " ${PN}-data "
