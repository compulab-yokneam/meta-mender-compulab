# Make the mender(-client) create a mender(-client)-data package.
# This package will be used by Debian installer.

PACKAGES:append = " ${PN}-data "

FILES:${PN}:remove = " \
    /data/mender/device_type \
    /data/mender/mender.conf \
"

FILES:${PN}-data = " \
    /data/mender/device_type \
    /data/mender/mender.conf \
"

RDEPENDS:${PN}:append = " ${PN}-data "
