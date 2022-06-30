FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://mender.conf.in \
    file://mender.in \
    file://1000-Remove-the-old-no-longer-present-calls.patch \
"

do_install:append() {
    install -d ${D}${sysconfdir}/udev/mount.blacklist.d
    install -d ${D}$/data/mender
    sed "s/MENDER_ROOTFS_PART_A/${MENDER_ROOTFS_PART_A}/;s/MENDER_ROOTFS_PART_B/${MENDER_ROOTFS_PART_B}/" ${WORKDIR}/mender.in | tee ${D}${sysconfdir}/udev/mount.blacklist.d/mender
    sed "s/MENDER_ROOTFS_PART_A/${MENDER_ROOTFS_PART_A}/;s/MENDER_ROOTFS_PART_B/${MENDER_ROOTFS_PART_B}/" ${WORKDIR}/mender.conf.in | tee ${D}/data/mender/mender.conf
}

RDEPENDS:${PN} += " bash "
