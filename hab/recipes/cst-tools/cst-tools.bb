LICENSE = "Unknown"
LIC_FILES_CHKSUM = "file://LICENSE.nxp;md5=6604ef69bd4ea2c604f8779985efd277"

SRC_URI = "file://cst-3.1.0.tgz \
	file://csf.in \
	file://csf.u \
	file://csf.k \
	file://csf.f \
	file://gen_keys.sh \
	file://gen_srk.sh \
	file://makefile \
"

DEPENDS = "openssl-native u-boot-compulab linux-compulab"

S = "${WORKDIR}/release"

do_configure () {
	install -d ${S}/tools
	cp ${WORKDIR}/csf* ${S}/tools
	cp ${WORKDIR}/gen_* ${S}/tools
	chmod a+x ${S}/tools/*
	cp ${WORKDIR}/makefile ${S}/
	cd ${S}
}

do_compile () {
	# You will almost certainly need to add additional arguments here
	cd ${S}
	oe_runmake build
}

do_install () {
	install -d ${D}/boot/signed/u
	install -d ${D}/boot/signed/k
	install -d ${D}/boot/signed/f
	install -m 0644 ${DEPLOY_DIR_IMAGE}/cst-tools/hab/signed/u/u-boot.imx.signed ${D}/boot/signed/u/u-boot.imx.signed
	install -m 0644 ${DEPLOY_DIR_IMAGE}/cst-tools/hab/signed/k/zImage.signed ${D}/boot/signed/k/zImage.signed
	install -m 0644 ${DEPLOY_DIR_IMAGE}/cst-tools/hab/signed/f/fuse.out ${D}/boot/signed/f/fuse.out
	ln -fs signed/k/zImage.signed ${D}/boot/
	ln -fs signed/u/u-boot.imx.signed ${D}/boot/
}

do_copy_signed() {
	cp ${DEPLOY_DIR_IMAGE}/cst-tools/hab/signed/u/u-boot.imx.signed ${DEPLOY_DIR_IMAGE}/u-boot.imx
	cp ${DEPLOY_DIR_IMAGE}/cst-tools/hab/signed/k/zImage.signed ${DEPLOY_DIR_IMAGE}/zImage.signed
}

do_sign () {
	cd ${DEPLOY_DIR_IMAGE}/cst-tools/hab
	../bin/csf.u
	../bin/csf.k
	../bin/csf.f
}

do_deploy () {
        install -d ${DEPLOY_DIR_IMAGE}/cst-tools
        install -d ${DEPLOY_DIR_IMAGE}/cst-tools/linux64/bin
	for d in crts bin ca;do
	cp -a ${S}/${d} ${DEPLOY_DIR_IMAGE}/cst-tools/
	done
	cp -a ${S}/keys/hab4_pki_tree.sh ${DEPLOY_DIR_IMAGE}/cst-tools/crts/
	ln -fs crts ${DEPLOY_DIR_IMAGE}/cst-tools/keys
	cp -a ${S}/linux64/bin/cst ${DEPLOY_DIR_IMAGE}/cst-tools/linux64/bin/
	do_sign
	do_copy_signed
}

addtask deploy before do_install after do_compile

PROVIDES += "cst-tools"

FILES_${PN} = " \
	/boot/* \
"

PACKAGE_ARCH = "${MACHINE_ARCH}"
