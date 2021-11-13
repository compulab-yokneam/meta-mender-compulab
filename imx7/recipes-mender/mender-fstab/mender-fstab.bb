FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SUMMARY = "Mender /etc/fstab for cl-som-imx7"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://COPYING;md5=814ac7f4503976ac3de0a9b8210566b8"

SRC_URI = " \
    file://fstab \
    file://COPYING \
"

do_compile() {
	:
}

do_install() {
    install -d ${D}/etc
    install -m 0644 ${WORKDIR}/fstab ${D}/etc/
}

FILES_${PN} += "/etc/"

RPROVIDES_${PN} += "fstab"

PACKAGE_ARCH = "all"
COMPATIBLE_MACHINE = "(cl-som-imx7)"

do_populate_lic[noexec] = "1"
