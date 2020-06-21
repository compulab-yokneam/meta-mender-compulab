# Configuring the build

## Setup Yocto environment

### Mender

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Initialize and sync repo manifest:
```
repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-sumo -m imx-4.14.98-2.0.0_demo_mender.xml
repo sync
```

### CompuLab

* Download CompuLab meta layer:
```
git clone -b imx8 https://github.com/compulab-yokneam/meta-mender-compulab.git sources/meta-mender-compulab/
```

## Setup build environment
* Set a CompuLab machine:

CompuLab machine | CL-SOM-iMX8 | UCM-iMX8M-Mini |
--- | --- | --- |
Environment setting | `MACHINE=cl-som-imx8` | `MACHINE=ucm-imx8m-mini` |


* Initialize the build environment:
```
source sources/meta-mender-compulab/imx8/tools/setup-env -b build-mender-${MACHINE}
```
* Building the image:
```
bitbake -k core-image-base
```

## Deployment
### Create an image file
* Goto the `tmp/deploy/images/${MACHINE}` directory:
```
cd tmp/deploy/images/${MACHINE}
```

* Deploy the image:
```
bmaptool copy core-image-base-${MACHINE}.sdimg /path/to/mender.sd.img
```

* Deploy the machine bootloader:
```
dd if=imx-boot-${MACHINE}-sd.bin-flash_evk of=/path/to/mender.sd.img bs=1K seek=33 conv=notrunc
```

### Create a bootable sd card
* Deploy the image to sd card:
```
sudo dd if=/path/to/mender.sd.img of=/dev/sdX bs=1M status=progress
```

## Pre-Built image
* [core-image-full-cmdline image](https://drive.google.com/drive/folders/1HpV_NiedoRvke40CwdiyJqrNYjlVLGOS)

## References
* https://hub.mender.io/t/nxp-i-mx-8m-mini-evaluation-kit/659
