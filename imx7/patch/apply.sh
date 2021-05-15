#!/bin/bash -xe 

F=${BUILDDIR}/../sources/meta-mender
B=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

M=$(git -C ${F} status --null  meta-mender-core/classes/mender-setup.bbclass | awk '$0=$1')

[[ -z ${M} ]] && patch -d ${F} -p 1 < ${B}/mender-setup.bbclass.patch
