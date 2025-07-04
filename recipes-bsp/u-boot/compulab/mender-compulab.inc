SRC_URI:append = " \
	file://0005-Compulab-Integration-of-Mender-boot-code-into-U-Boot.patch \
	file://0006-mender-imx8mp-Add-fw_env.conf-redundent-layout.patch \
	file://mender-uboot.cfg \
"

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

# These vars are for fw_env.conf; tbd -- were not used ?
# MENDER_UBOOT_MMC_ENV_LINUX_DEVICE_PATH = "/dev/mmcblk2boot0"
# MENDER_UBOOT_MMC_ENV_LINUX_DEVICE_PATH_REDUND = "/dev/mmcblk2boot0"
