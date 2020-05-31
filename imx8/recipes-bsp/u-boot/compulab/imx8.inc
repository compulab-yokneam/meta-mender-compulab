SRC_URI_remove = "file://0001-Add-Mender-support.patch"
SRC_URI_remove = "file://0002-Improve-boot-startup-time.patch"
SRC_URI_remove = "file://0003-Allow-Mender-to-live-in-eMMC.patch"

SRC_URI_append += " \
	file://0201-Add-Mender-support.patch \
	file://0202-Improve-boot-startup-time.patch \
	file://0203-Allow-Mender-to-live-in-eMMC.patch \
"

MENDER_UBOOT_ENV_STORAGE_DEVICE_OFFSET_1_${MACHINE} = "0x1000"
# Fix this location for redundand environment offset
# MENDER_UBOOT_ENV_STORAGE_DEVICE_OFFSET_2_${MACHINE} = "0x6000"

BOOTENV_SIZE_${MACHINE}                             = "0x4000"
MENDER_UBOOT_STORAGE_DEVICE_cl-som-imx8             ?= "1"
MENDER_UBOOT_STORAGE_DEVICE_ucm-imx8m-mini          ?= "0"
MENDER_UBOOT_STORAGE_DEVICE_mcm-imx8m-mini          ?= "0"
