FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SUMMARY = "U-Boot boot script generator"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

DEPENDS = "u-boot-mkimage-native"

SRC_FILE = "${@bb.utils.contains('MENDER_FEATURES_ENABLE', 'mender-partuuid', 'boot.cmd.uuid', 'boot.cmd', d)}"

SRC_URI = " \
    file://boot.cmd.uuid \
    file://boot.cmd \
    file://boot.cmd.ai \
"

do_compile() {
	cat ${WORKDIR}/boot.cmd.ai ${WORKDIR}/${SRC_FILE} > ${WORKDIR}/boot.in
	mkimage -C none -A arm -T script -d ${WORKDIR}/boot.in ${WORKDIR}/boot.scr
	rm -rf ${WORKDIR}/boot.in
	( cat ${WORKDIR}/boot.cmd.ai; echo "setenv bootscript; boot" ) > ${WORKDIR}/boot.in
	mkimage -C none -A arm -T script -d ${WORKDIR}/boot.in ${WORKDIR}/boot.auto.scr
	rm -rf ${WORKDIR}/boot.in
}

inherit deploy

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${WORKDIR}/boot.scr ${DEPLOYDIR}
    install -m 0644 ${WORKDIR}/boot.auto.scr ${DEPLOYDIR}
}

do_install() {
    install -d ${D}/boot
    install -m 0644 ${WORKDIR}/boot.scr ${D}/boot/
    install -m 0644 ${WORKDIR}/boot.auto.scr ${D}/boot/
}

addtask do_deploy after do_compile before do_build

FILES_${PN} += "/boot/"

RPROVIDES_${PN} += "u-boot-script"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(cl-som-imx7)"
