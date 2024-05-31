do_install:prepend() {
    if [ -f ${B}/bin/linux_arm/mender-artifact ];then
        cp ${B}/bin/linux_arm/mender-artifact ${B}/bin/
    fi
}
