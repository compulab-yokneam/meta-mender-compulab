FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://fw_env.cl-som-imx7.config"

do_install_prepend_cl-som-imx7() {
    cp ${S}/../fw_env.cl-som-imx7.config ${S}/../fw_env.config
}
