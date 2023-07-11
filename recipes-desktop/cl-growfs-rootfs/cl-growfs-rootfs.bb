DESCRIPTION = "CompuLab grow rootfs dumb service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=a0750ac19cd2e5f4cf6dc7876e3dc353"

SRC_URI = " \
    file://COPYING \
"

ALLOW_EMPTY:${PN} = "1"

S = "${WORKDIR}"
