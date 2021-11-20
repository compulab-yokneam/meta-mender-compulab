FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SUMMARY = "Mender /etc/fstab" 
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://COPYING;md5=ad481d471c81529d3fb8d1338cb79431"

SRC_URI = " \
    file://fstab \
    file://COPYING \
"

do_install() {
    install -d ${D}/etc
    install -m 0644 ${WORKDIR}/fstab ${D}/etc/
}

FILES_${PN} += "/etc/"

RPROVIDES_${PN} += "fstab"

PACKAGE_ARCH = "all"
COMPATIBLE_MACHINE = "(mx8|mx7)"

do_compile[noexec] = "1"
do_populate_lic[noexec] = "1"
