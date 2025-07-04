SRC_URI:append = " \
	file://0001-cpl-imx8m-mini-Line-up-with-distro_bootcmd-variable-.patch \
	file://0005-Compulab-Integration-of-Mender-boot-code-into-U-Boot.patch \
	file://0006-mender-imx8mp-Add-fw_env.conf-redundent-layout.patch \
	file://0007-compulab-imx8mm-Integration-of-Mender-boot-code-into.patch \
	file://mender-uboot.cfg \
"

# Remove this file in order to prevent config validation failure
# before merging the mender cfg fragments
do_configure:prepend() {
	rm -rf ${S}/mender_Kconfig_fragment
}

MENDER_UBOOT_AUTO_CONFIGURE = "0"
BOOTENV_SIZE = "0x20000"
MENDER_UBOOT_ENV_STORAGE_DEVICE_OFFSET_1 = "0x380000"
MENDER_UBOOT_ENV_STORAGE_DEVICE_OFFSET_2 = "0x3B0000"
MENDER_UBOOT_STORAGE_DEVICE = "2"
MENDER_UBOOT_CONFIG_SYS_MMC_ENV_PART = "1"
MENDER_DTB_NAME_FORCE = "${UBOOT_DTB_NAME}"
