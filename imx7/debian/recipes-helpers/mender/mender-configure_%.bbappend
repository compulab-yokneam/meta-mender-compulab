# Make the mender-configure create a mender-configure-data package.
# This package will be used by Debian installer.

PACKAGES_append = " ${PN}-data "

FILES_${PN}_remove = " \
    ${datadir}/mender/modules/v3/mender-configure \
    ${datadir}/mender/inventory/mender-inventory-mender-configure \
    /var/lib/mender-configure \
    /data/mender-configure \
"

FILES_${PN}-demo_remove = " \
    /data/mender-configure/device-config.json \
"

FILES_${PN}-data = " \
    ${datadir}/mender/modules/v3/mender-configure \
    ${datadir}/mender/inventory/mender-inventory-mender-configure \
    /var/lib/mender-configure \
    /data/mender-configure \
    /data/mender-configure/device-config.json \
"

RDEPENDS_${PN}_append = " ${PN}-data "
