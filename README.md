# Configuring the build

## Setup Yocto environment

### NXP

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Initialize NXP repo manifest:
```
repo init -u git://source.codeaurora.org/external/imx/imx-manifest.git -b imx-linux-zeus -m imx-5.4.24-2.1.0.xml
repo sync
```

### Mender
* Initialize Mender repo manifest:
```
mkdir -p .repo/local_manifests
cd .repo/local_manifests
wget https://raw.githubusercontent.com/mendersoftware/meta-mender-community/zeus/scripts/mender-no-setup.xml
cd -
```

### CompuLab
* Initialize CompuLab repo manifest:
```
mkdir -p .repo/local_manifests
cd .repo/local_manifests
wget https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/zeus/templates/mender-compulab-setup.xml
cd -
```

### Sync Them all
```
repo sync
```

## Setup build environment
* Set a CompuLab machine:

CompuLab machine | UCM-iMX8M-Mini | MCM-iMX8M-Mini | iot-gate-imx8 |
--- | --- | --- | --- |
Environment setting | `MACHINE=ucm-imx8m-mini` |`MACHINE=mcm-imx8m-mini` |`MACHINE=iot-gate-imx8` |


* Initialize the build environment:
```
source sources/meta-mender-compulab/tools/setup-env -b build-mender-${MACHINE}
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
