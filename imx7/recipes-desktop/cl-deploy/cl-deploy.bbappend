FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

CL_DEPLOY_MOD = "${@bb.utils.contains('MENDER_FEATURES_ENABLE', 'mender-partuuid', '1', '0', d)}"
