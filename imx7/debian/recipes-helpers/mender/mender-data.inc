# Make the mender(-client) create a mender(-client)-data package.
# This package will be used by Debian installer.

PACKAGES_append = " ${PN}-data "

FILES_${PN}_remove = " \
    /data/mender/device_type \
    /data/mender/mender.conf \
"

FILES_${PN}-data = " \
    /data/mender/device_type \
    /data/mender/mender.conf \
"

RDEPENDS_${PN}_append = " ${PN}-data "
