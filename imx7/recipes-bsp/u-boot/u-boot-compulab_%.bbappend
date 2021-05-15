FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

require recipes-bsp/u-boot/u-boot-mender.inc

DEPENDS += "u-boot-script"

MENDER_UBOOT_AUTO_CONFIGURE = "0"
BOOTENV_SIZE = "0x2000"

SRC_URI += "\
    file://0001-cl-som-imx7-config-Enable-part-command.patch \
    file://0002-cl-som-imx7-Add-support-to-mender.patch \
"

PROVIDES += "u-boot-fslc"
