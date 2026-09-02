FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
	file://02_compulab_console_grub.cfg;subdir=git \
"

SRC_URI:append:rootfs-dtb = " \
	file://02_compulab_kernel_devicetree_grub.cfg;subdir=git \
	file://0001-Add-85_mender_load_dtb_grub.cfg.patch \
"
