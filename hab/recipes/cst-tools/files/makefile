all: build

bin:
	mkdir -p $@

crts/SRK_1_2_3_4_table.bin:
	cd crts && ../tools/gen_keys.sh
	
csf:	crts/SRK_1_2_3_4_table.bin bin
	cp tools/csf* bin/

srk:	crts/SRK_1_2_3_4_table.bin
	cd crts && ../tools/gen_srk.sh

clean:
	rm -rf bin crts/*

build: srk csf
