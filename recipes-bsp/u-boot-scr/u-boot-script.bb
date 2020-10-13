LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://${WORKDIR}/README;md5=2456088a0455a82ac9e16b007de97c03"

DEPENDS = "u-boot-mkimage-native"

SRC_URI = "file://boot.script \
	file://README \
"

do_compile() {
	mkimage -C none -A arm -T script -d "${WORKDIR}/boot.script" boot.scr
}

do_install() {
	install -d ${D}/boot
	install -m 0644 ${WORKDIR}/boot.script ${D}/boot/boot.script
}

inherit deploy

do_deploy() {
	install -d ${DEPLOYDIR}
	install -m 0644 boot.scr ${DEPLOYDIR}
}

addtask do_deploy after do_compile before do_build

FILES_${PN} += "/boot/"

RPROVIDES_${PN} += "u-boot-script"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(mcm-imx8m-mini|ucm-imx8m-mini|iot-gate-imx8)"
