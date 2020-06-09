all: build

bin:
	mkdir $@

crts:
	mkdir $@

keys:	crts
	cd crts && ../tools/gen_keys.sh
	
csf:	keys bin
	cp tools/csf* bin/

srk:	keys
	cd crts && ../tools/gen_srk.sh

clean:
	rm -rf crts bin

build: srk csf
