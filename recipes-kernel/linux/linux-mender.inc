do_configure:append() {
    echo "CONFIG_EFI=y" >> ${B}/.config
}

PROVIDES += "linux-imx"
RPROVIDES:${PN} += "linux-imx"
