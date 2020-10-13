do_install_preppend() {
    for dtb_path in ${KERNEL_DEVICETREE}; do
	dtb_dir=$(dirname $dtb_path)
	dtb_path=$(basename $dtb_path)
	mkdir -p ${DEPLOY_DIR_IMAGE}/$dtb_dir
        cp ${DEPLOY_DIR_IMAGE}/$dtb_path ${DEPLOY_DIR_IMAGE}/$dtb_dir/$dtb_path
    done
}

addtask install_preppend before do_install after do_compile

DEPENDS += "linux-imx"
