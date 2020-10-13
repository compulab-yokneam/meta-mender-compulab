FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

include compulab/imx8mm.inc

PROVIDES += "u-boot"
RPROVIDES_${PN} += "u-boot"

do_configure_efi() {
    sed -i '/# CONFIG_EFI_LOADER is not set/d' ${S}/configs/${MACHINE}_defconfig
}

addtask do_configure_efi after do_patch before do_configure
