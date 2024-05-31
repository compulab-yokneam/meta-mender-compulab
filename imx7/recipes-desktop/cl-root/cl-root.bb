# Simple recipe to add executable to run automated
# CompuLab Switch Rootfs Tool

DESCRIPTION = "CompuLab Switch Rootfs Tool"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"
MAINTAINER = "compulab@compulab.com"

PR = "r0"

SRC_URI = " \
	file://cl-root \
"
S = "${WORKDIR}"

do_install() {
	mkdir -p ${D}/usr/local/bin/
	install -m 0755 ${S}/cl-root ${D}/usr/local/bin/
}

FILES:${PN} = " \
	/usr/local/bin/* \
"

RDEPENDS:${PN} = "bash dialog grub-editenv" 
