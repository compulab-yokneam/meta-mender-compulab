DESCRIPTION = "Mender Deployment Tool"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://COPYING;md5=cd2719d4fb3e8cee5ca467d40ae33f69"

SRC_URI = " \
	file://mr-deploy \
	file://COPYING \
"

S = "${WORKDIR}"

do_install() {
	install -d ${D}${prefix}/local/bin
	install -m 0755 ${S}/mr-deploy ${D}${prefix}/local/bin/
}

FILES_${PN} = " \
	${prefix}/local/bin/* \
"

RDEPENDS_${PN} = " bash cl-deploy cl-uboot "
