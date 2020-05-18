FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI+ = "file://boot.cmd"

PROVIDES += "u-boot-script"

COMPATIBLE_MACHINE = "(cl-som-imx7)"
