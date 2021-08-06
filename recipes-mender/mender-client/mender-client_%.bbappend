FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://mender.conf.in \
    file://mender.in \
"

do_install_append() {
    install -d ${D}${sysconfdir}/udev/mount.blacklist.d
    install -d ${D}$/data/mender
    sed "s/MENDER_ROOTFS_PART_A/${MENDER_ROOTFS_PART_A}/;s/MENDER_ROOTFS_PART_B/${MENDER_ROOTFS_PART_B}/" ${WORKDIR}/mender.in | tee ${D}${sysconfdir}/udev/mount.blacklist.d/mender
    sed "s/MENDER_ROOTFS_PART_A/${MENDER_ROOTFS_PART_A}/;s/MENDER_ROOTFS_PART_B/${MENDER_ROOTFS_PART_B}/" ${WORKDIR}/mender.conf.in | tee ${D}/data/mender/mender.conf
}

RDEPENDS_${PN} += " bash "
