# CompuLab cst-tools

## How to build

<pre>
bitbake -k cst-tools
</pre>

## Output Layout

<pre>
cst-tools/
├── bin
│   ├── csf.f -- fuse values creat script
│   ├── csf.k -- kernel signing script
│   └── csf.u -- u-boot signing script
├── crts
│   ├── hab4_pki_tree.sh -- script
│   ├── ...
│   ├── ...
├── hab
│   ├── signed
│   │   ├── f
│   │   │   └── fuse.out -- fuse values
│   │   ├── k
│   │   │   └── zImage.signed -- signed kernel
│   │   └── u
│   │       └── u-boot.imx.signed -- signed u-boot
│   ├── SPL
│   ├── SPL.log
│   ├── u-boot-ivt.img
│   ├── u-boot-ivt.img.log
│   └── zImage
├── keys -> crts
└── linux64
    └── bin
        └── cst
</pre>

## How to use

### Signing with already generated keys

Goto `hab` input directory:
<pre>
cd ${BUILDIR}/tmp/deploy/images/${MACHINE}/cst-tools/hab
</pre>

* Kernel signing

|Input | Script | Output |
|--- | --- |---|
|zImage<br>crts/\*<br>keys/\*<br>bin/csf.in| ../bin/csf.k |signed/k/zImage.signed

<pre>
../bin/csf.k
stat signed/k/zImage.signed
</pre>

* U-Boot  signing

| Input | Script | Output |
|--- | --- |---|
|SPL<br>SPL.log<br>u-boot-ivt.img<br>u-boot-ivt.img.log<br>crts/\*<br>keys/\*<br>bin/csf.in| ../bin/csf.u |signed/u/u-boot.imx.signed

<pre>
../bin/csf.u
stat signed/u/u-boot.imx.signed
</pre>

* fuse  signing
<pre>
../bin/csf.f
stat signed/f/fuse.out
</pre>

### Generate new keys
Goto `crts` directory:
<pre>
cd ${BUILDIR}/tmp/deploy/images/${MACHINE}/cst-tools/crts
</pre>

* Issue:
<pre>
cat << eof | ./hab4_pki_tree.sh
n
n
2048
5
4
y
eof
</pre>
