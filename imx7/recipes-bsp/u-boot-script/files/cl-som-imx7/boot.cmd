# Try updating the u-boot 1-st
load mmc 0:2 ${loadaddr} boot/boot.update.scr && source ${loadaddr}

run mender_setup

setenv bootargs "console=${console},${baudrate} root=${mender_kernel_root} rootwait rw"
load mmc 0:2 ${loadaddr} boot/auto && setenv bootargs ${bootargs} init=/usr/local/bin/cl-init

mmc dev ${mender_uboot_dev}
load ${mender_uboot_root} ${loadaddr} /boot/${kernel}
load ${mender_uboot_root} ${fdtaddr} /boot/${fdtfile}
bootz ${loadaddr} - ${fdtaddr}
run mender_try_to_recover
