LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${UNPACKDIR}/README;md5=2456088a0455a82ac9e16b007de97c03"

DEPENDS = "u-boot-mkimage-native"

SRC_URI = "file://boot.script \
	file://README \
"

do_compile() {
	mkimage -C none -A arm -T script -d ${UNPACKDIR}/boot.script ${UNPACKDIR}/boot.scr
}

do_install() {
	install -d ${D}/usr/share/compulab
	install -m 0644 ${UNPACKDIR}/boot.script ${D}/usr/share/compulab/boot.mender.script
}

inherit deploy

do_deploy() {
	install -d ${DEPLOYDIR}
	install -m 0644 ${UNPACKDIR}/boot.scr ${DEPLOYDIR}/boot.mender.scr
}

addtask do_deploy after do_compile before do_build

FILES:${PN} += "/usr/share/compulab/"

RPROVIDES:${PN} += "u-boot-mender-script"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(mx8)"
