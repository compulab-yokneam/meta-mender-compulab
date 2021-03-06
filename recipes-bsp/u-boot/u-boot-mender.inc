FILESEXTRAPATHS_prepend := "${THISDIR}/compulab/imx8mm:"

include compulab/imx8mm.inc

PROVIDES += "u-boot"
RPROVIDES_${PN} += "u-boot"

do_configure_efi() {
    for config in ${UBOOT_MACHINE}; do
        sed -i '/# CONFIG_EFI_LOADER is not set/d;$ a CONFIG_EFI_LOADER=y' ${S}/configs/${config}
    done
}

addtask do_configure_efi after do_patch before do_configure
