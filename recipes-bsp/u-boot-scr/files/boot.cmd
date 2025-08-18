setenv xtrace yes
run mender_setup
load ${mender_uboot_root} ${loadaddr} boot/${image}
load ${mender_uboot_root} ${fdt_addr_r} boot/${fdtfile}
setenv bootargs "console=${console},${baudrate} rootwait ${boot_opt}"

setenv AD_SRC DONT_AUTODEPLOY
if test "${AD_SRC}" = "${iface}"; then
	setenv bootargs "${bootargs} init=/usr/local/bin/cl-init root=/dev/sda2"
else
	setenv bootargs "${bootargs} root=PARTUUID=${mender_uboot_root_name} rw"
fi

booti ${loadaddr} - ${fdt_addr_r}
run mender_try_to_recover
