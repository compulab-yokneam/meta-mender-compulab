run mender_setup
setenv bootargs 'console=${console},${baudrate} root=${mender_kernel_root} rootwait rw'
mmc dev ${mender_uboot_dev}
load ${mender_uboot_root} ${loadaddr} /boot/${kernel}
load ${mender_uboot_root} ${fdtaddr} /boot/${fdtfile}
bootz ${loadaddr} - ${fdtaddr}
run mender_try_to_recover
