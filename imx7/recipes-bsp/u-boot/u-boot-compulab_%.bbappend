FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

require recipes-bsp/u-boot/u-boot-mender.inc

DEPENDS += "u-boot-script"

MENDER_UBOOT_AUTO_CONFIGURE = "0"
BOOTENV_SIZE = "0x2000"

SRC_URI += "\
    file://0001-cl-som-imx7-Add-u-boot.imx-target.patch \
    file://0002-cl-som-imx7-Add-support-to-mender.patch \
"

do_install_append_cl-som-imx7 () {

	install -d ${D}/boot/hab
	install -m 644 ${B}/u-boot-ivt.img ${D}/boot/hab/u-boot-ivt.img
	install -m 644 ${B}/u-boot-ivt.img.log ${D}/boot/hab/u-boot-ivt.img.log
	install -m 644 ${B}/SPL ${D}/boot/hab/SPL
	install -m 644 ${B}/SPL.log ${D}/boot/hab/SPL.log
}

do_deploy_append_cl-som-imx7 () {

	install -d ${DEPLOY_DIR_IMAGE}/cst-tools/hab
	install -m 644 ${B}/u-boot-ivt.img ${DEPLOY_DIR_IMAGE}/cst-tools/hab/u-boot-ivt.img
	install -m 644 ${B}/u-boot-ivt.img.log ${DEPLOY_DIR_IMAGE}/cst-tools/hab/u-boot-ivt.img.log
	install -m 644 ${B}/SPL ${DEPLOY_DIR_IMAGE}/cst-tools/hab/SPL
	install -m 644 ${B}/SPL.log ${DEPLOY_DIR_IMAGE}/cst-tools/hab/SPL.log
}

PROVIDES += "u-boot-fslc"
