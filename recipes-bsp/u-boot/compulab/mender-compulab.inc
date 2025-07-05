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

DO_POST_PATCH:compulab-mx8mm = "1"
DO_POST_PATCH:compulab-mx8mp = "0"

# for same reason the platform specific do_configure:prepend()
# from the original u-boot-compulab recipe gets ignored by the mender yocto build
# added this task for the mx8mm platform only
do_post_patch_func() {
    # Merge common defconfig with specific fraggment to get specific defconfig
    local CONFDIR=configs
    cd ${S}
    scripts/kconfig/merge_config.sh  -O ${CONFDIR}/ -m  ${CONFDIR}/cl-imx8m-mini_defconfig ${CONFDIR}/${MACHINE}.config
    mv ${CONFDIR}/.config ${CONFDIR}/${MACHINE}_defconfig
    cd -
}

do_post_patch() {
    if [ "${DO_POST_PATCH}" = "1" ];then
        do_post_patch_func
    fi
}
addtask post_patch after do_patch before do_configure

MENDER_UBOOT_AUTO_CONFIGURE = "0"
BOOTENV_SIZE = "0x20000"
MENDER_UBOOT_ENV_STORAGE_DEVICE_OFFSET_1 = "0x380000"
MENDER_UBOOT_ENV_STORAGE_DEVICE_OFFSET_2 = "0x3B0000"
MENDER_UBOOT_STORAGE_DEVICE = "2"
MENDER_UBOOT_CONFIG_SYS_MMC_ENV_PART = "1"
MENDER_DTB_NAME_FORCE = "${UBOOT_DTB_NAME}"
