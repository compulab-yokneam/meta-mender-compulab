do_configure_append() {
    echo "CONFIG_EFI=y" >> ${B}/.config
}

PROVIDES += "linux-imx"
RPROVIDES_${PN} += "linux-imx"
