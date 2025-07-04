setenv xtrace yes
run mender_setup
load ${mender_uboot_root} ${loadaddr} boot/${image}
load ${mender_uboot_root} ${fdt_addr_r} boot/${fdtfile}
setenv bootargs "console=${console},${baudrate} root=PARTUUID=${mender_uboot_root_name} rootwait rw ${boot_opt}"
booti ${loadaddr} - ${fdt_addr_r}
run mender_try_to_recover
