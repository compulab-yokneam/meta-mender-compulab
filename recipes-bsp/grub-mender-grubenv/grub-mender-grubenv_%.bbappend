FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://02_compulab_console_grub.cfg;subdir=git \
		file://02_compulab_kernel_devicetree_grub.cfg;subdir=git \
		file://0001-90_mender_boot_grub.cfg-Add-devicetree.patch \
"
