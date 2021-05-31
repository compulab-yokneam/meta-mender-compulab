function sign_image_part() {

[[ -b ${SRC} && -z ${PTUUID} ]] && eval $(blkid ${SRC} | awk -F":" '($0=$2)')

[[ -z ${PTUUID} ]] && return

cat << eof | fdisk ${DST}
x
i
0x${PTUUID}
r
w
eof
}

sign_image_part
