#!/bin/bash

set -e

fast_boot() {
	for _c in s u b;do
		echo ${_c} > /proc/sysrq-trigger
	done
}

validate_bootcmd() {
	fw_printenv bootcmd | grep -q distro_bootcmd  && return 0 || true
	fw_setenv bootcmd "run distro_bootcmd; $(fw_printenv bootcmd | awk -F"=" '$0=$2')"
	fast_boot
}

validate_bootcmd
