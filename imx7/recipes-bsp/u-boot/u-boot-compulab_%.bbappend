FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DEPENDS += "u-boot-script"

MENDER_UBOOT_AUTO_CONFIGURE = "0"
BOOTENV_SIZE = "0x2000"

SRC_URI += "\
    file://0001-cl-som-imx7-config-Enable-part-command.patch \
    file://0002-cl-som-imx7-Add-support-to-mender.patch \
"

PATCH_ENV = "${@bb.utils.contains('MENDER_FEATURES_ENABLE', 'mender-partuuid', '1' , '0' , d)}"

do_provide_mender_defines:append() {
if [ ${PATCH_ENV} = "1" ];then
cat >> ${S}/include/config_mender_defines.h << eof

#ifndef HEADER_CONFIG_MENDER_CUSTOM_H
#define HEADER_CONFIG_MENDER_CUSTOM_H

#ifdef MENDER_STORAGE_DEVICE
#undef MENDER_STORAGE_DEVICE
#endif

#define MENDER_STORAGE_DEVICE ""

#ifdef MENDER_STORAGE_DEVICE_BASE
#undef MENDER_STORAGE_DEVICE_BASE
#endif

#define MENDER_STORAGE_DEVICE_BASE "PARTUUID="

#endif /* !HEADER_CONFIG_MENDER_CUSTOM_H */
eof
fi
}
PROVIDES += "u-boot-fslc"

do_deploy:append() {
        #install -D -m 644 ${B}/${config}/u-boot-initial-env-${type} ${DEPLOYDIR}/uboot.env
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${DEPLOYDIR}/uboot.env
}

do_rm_work[noexec] = "1"
