LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${WORKDIR}/README;md5=9f3e9717b35d0dea0c634e9529ad509d"

SRC_URI = "file://mr-deploy \
	file://README \
"

do_compile() {
	:
}

do_install() {
	install -d ${D}/usr/local/bin
	install -m 0755 ${WORKDIR}/mr-deploy ${D}/usr/local/bin/mr-deploy
}

FILES:${PN} += "/usr/local/bin/"

RPROVIDES:${PN} += "mr-deploy"
RDEPENDS:${PN} += "cl-deploy cl-uboot bash"

PACKAGE_ARCH = "${MACHINE_ARCH}"
