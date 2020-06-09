do_deploy_append_cl-som-imx7 () {

	install -d ${DEPLOY_DIR_IMAGE}/cst-tools/hab
	install -m 644 ${B}/arch/arm/boot/zImage ${DEPLOY_DIR_IMAGE}/cst-tools/hab/zImage

}
