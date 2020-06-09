#!/bin/bash

create_fuse() {
hexdump -e '/4 "0x"' -e '/4 "%X""\n"' ../crts/SRK_1_2_3_4_fuse.bin | awk 'BEGIN {BANK=5; ADDR=0;} { BANK+=(ADDR==0); $0="fuse prog "BANK" "ADDR" "$0; ADDR+=1 ; ADDR%=4;}1'
}

O=signed/f
f=fuse.out

install -d ${O}

create_fuse > ${O}/${f}
