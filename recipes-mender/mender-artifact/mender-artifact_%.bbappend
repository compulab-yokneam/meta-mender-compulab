do_install_prepend() {
    if [ -f ${B}/bin/linux_arm64/mender-artifact ];then
        cp ${B}/bin/linux_arm64/mender-artifact ${B}/bin/
    fi
}
