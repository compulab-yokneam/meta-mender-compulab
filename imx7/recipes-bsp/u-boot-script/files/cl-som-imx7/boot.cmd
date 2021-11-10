# Issue setenv skip_inst yes after installation
# in order to bypass the auto installer look up logics
if env exist skip_inst;then;
else
setenv inst_dev 0
setenv inst_part 2

setenv sd_inst  'setenv kernel_root /dev/mmcblk0p2; setenv iface mmc;'
setenv usb_inst 'usb start; setenv kernel_root /dev/sda2; setenv iface usb;'
setenv bootlist usb_inst sd_inst

for src in ${bootlist};do
run ${src}
# Try updating the u-boot 1-st
load ${iface} ${inst_dev}:${inst_part} ${loadaddr} boot/boot.update.scr && source ${loadaddr}
load ${iface} ${inst_dev}:${inst_part} ${loadaddr} boot/auto && setenv auto_install 1

if test ${auto_install} = 1; then
setenv bootargs "console=${console},${baudrate} root=${kernel_root} rootwait rw "
setenv bootargs ${bootargs} init=/usr/local/bin/cl-init
load ${iface} ${inst_dev}:${inst_part} ${loadaddr} /boot/${kernel}
load ${iface} ${inst_dev}:${inst_part} ${fdtaddr} /boot/${fdtfile}
bootz ${loadaddr} - ${fdtaddr}
fi
done
fi

run mender_setup
setenv bootargs "console=${console},${baudrate} root=${mender_kernel_root} rootwait rw"
mmc dev ${mender_uboot_dev}
load ${mender_uboot_root} ${loadaddr} /boot/${kernel}
load ${mender_uboot_root} ${fdtaddr} /boot/${fdtfile}
bootz ${loadaddr} - ${fdtaddr}
run mender_try_to_recover
