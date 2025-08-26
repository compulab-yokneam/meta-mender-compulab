DESCRIPTION = "CompuLab U-Boot bootcmd updater"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=9b623862afcf9bb6406ec305c8380d15"

inherit systemd

RDEPENDS:${PN}:append = " bash "

SRC_URI:append = " \
    file://COPYING \
    file://cl-bootcmd.sh \
    file://cl-bootcmd.service \
"

FILES:${PN}:append = " \
    ${bindir}/* \
    ${systemd_unitdir}/* \
"

S = "${UNPACKDIR}"

do_configure() {
	:
}

do_compile() {
	:
}

do_install() {

    install -d -m 755 ${D}${bindir}
    install -m 0755 ${UNPACKDIR}/cl-bootcmd.sh ${D}/${bindir}/cl-bootcmd.sh

    install -d ${D}/${systemd_unitdir}/system
    install -m 644 ${UNPACKDIR}/${BPN}.service ${D}/${systemd_unitdir}/system/

    install -d ${D}${systemd_unitdir}/system/multi-user.target.wants
    ln -sf ../${BPN}.service ${D}${systemd_unitdir}/system/multi-user.target.wants/${BPN}.service
}

pkg_postinst_ontarget:${PN} () {
    systemctl --system enable cl-bootcmd.service
}

pkg_prerm:${PN} () {
    systemctl --system disable cl-bootcmd.service
}
