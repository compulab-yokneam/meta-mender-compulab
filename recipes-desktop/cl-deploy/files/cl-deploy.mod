#!/bin/bash -xe

function help() {
cat << eoh
Please unset these variables: SRC DST image_sign PTUUID
Samples:
    unset SRC DST image_sign PTUUID
    # Apply a new UUID provided by image_sign
	image_sign=cafecafe DST=/dev/mmcblk2 source /path/to/cl-deploy.mod
    # Apply a new UUID generated by uuidgen
	DST=/dev/mmcblk2 source /path/to/cl-deploy.mod
    # Take the UUID from the SRC
	SRC=/dev/mmcblk1 DST=/dev/mmcblk2 source /path/to/cl-deploy.mod
eoh
}

function file_mender_mod1() {
    local _file=${mpoint}/${1}
    [[ -f ${_file} ]] || return
    mv ${_file} ${_file}.src
cat > ${_file} << eof
/dev/disk/by-partuuid/${image_sign}-02
/dev/disk/by-partuuid/${image_sign}-03
eof
}

function file_mender_mod() {
    local _file=${mpoint}/${1}
    [[ -f ${_file} ]] || return
    mv ${_file} ${_file}.src
cat > ${_file} << eof
{
    "RootfsPartA": "/dev/disk/by-partuuid/${image_sign}-02"
    "RootfsPartB": "/dev/disk/by-partuuid/${image_sign}-03"
}
eof
}

function file_grub_mod() {
    local _file=${mpoint}/${1}
    [[ -f ${_file} ]] || return
    sed -i "s/\(mender_rootfs[a,b]_uuid=\).*\(-0[[:digit:]]\)/\1${image_sign}\2/g" ${_file}
}

function file_extlinux_mod() {
    local _file=${mpoint}/${1}
    [[ -f ${_file} ]] || return
    sed -i "s/\(root=PARTUUID=\).*-0[[:digit:]]/\1${image_sign}-0${part_numder}/g" ${_file}
}

function file_fstab_mod() {
    local _file=${mpoint}/${1}
    [[ -f ${_file} ]] || return
    sed -i "s/\(PARTUUID=\).*\(-0[[:digit:]]\)/\1${image_sign}\2/g" ${_file}
}

function modify_image_p4() {
    declare -A files=( [/mender/mender.conf]="file_mender_mod" )
    for f in ${!files[@]};do command -v ${files[${f}]} &>/dev/null || continue; ${files[${f}]} ${f} ; done
}

function modify_image_p23() {
    declare -A files=( [/extlinux/extlinux.conf]="file_extlinux_mod" [/etc/fstab]="file_fstab_mod" [/etc/udev/mount.blacklist.d/mender]="file_mender_mod1")
    for f in ${!files[@]};do command -v ${files[${f}]} &>/dev/null || continue; ${files[${f}]} ${f} ; done
}

function modify_image_p1() {
    declare -A files=( [/EFI/BOOT/grub.cfg]="file_grub_mod" )
    for f in ${!files[@]};do command -v ${files[${f}]} &>/dev/null || continue; ${files[${f}]} ${f} ; done
}

function modify_image_data() {
    local _mpoint=${1}
    local _part_number=${2}
    declare part_mode_array=([1]="modify_image_p1" [2]="modify_image_p23" [3]="modify_image_p23" [4]="modify_image_p4")
    mpoint=${mpoint} patr_number=${part_numder} ${part_mode_array[${_part_number}]}
}

function modify_image_data_main() {
    declare -A partdl=( [mmc]="p" [loo]="p" [nvm]="p" [sda]="" )
    dst=$(basename ${device})
    p=${partdl[${dst:0:3}]}

    mpoint=$(mktemp --directory)

    for i in $(seq 1 4);do
        export device_base=${device}${p}
        mount ${device}${p}${i} ${mpoint}
        part_numder=${i} mpoint=${mpoint} modify_image_data ${mpoint} ${i}
        sync;sync;sync
        umount ${mpoint}
    done
}

function modify_image_uuid() {
cat << eof | sudo fdisk ${device}
x
i
0x${image_sign}
r
w
eof
}

function post_deploy() {
device=${DST}
[[ -z ${image_sign} ]] && image_sign=$(uuidgen --md5 --namespace @dns --name ${device} | awk -F"-" '$0=$1')
device=${device} image_sign=${image_sign} modify_image_uuid
device=${device} image_sign=${image_sign} modify_image_data_main
}

[[ -b ${DST} ]] || return

[[ -n ${SRC} ]] && eval $(blkid ${SRC} -o export)
[[ -n ${PTUUID} ]] && image_sign=${PTUUID}

post_deploy
