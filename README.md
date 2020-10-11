# Configuring the build

## Setup Yocto environment

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```

## Initialize repo manifests

* NXP
```
repo init -u git://source.codeaurora.org/external/imx/imx-manifest.git -b imx-linux-zeus -m imx-5.4.24-2.1.0.xml
repo sync
```

* Mender
```
mkdir -p .repo/local_manifests
cd .repo/local_manifests
wget https://raw.githubusercontent.com/mendersoftware/meta-mender-community/zeus/scripts/mender-no-setup.xml
cd -
```

* CompuLab
```
mkdir -p .repo/local_manifests
cd .repo/local_manifests
wget https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/zeus/scripts/mender-compulab-setup.xml
cd -
```

* Sync Them all
```
repo sync
cd .repo/local_manifests
ln -sf ../../sources/meta-mender-community/scripts/mender-no-setup.xml .
ln -sf ../../sources/meta-mender-compulab/scripts/mender-compulab-setup.xml .
cd -
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

### Create a bootable sd card
* Deploy the image to sd card:
```
sudo dd if=/path/to/mender.sd.img of=/dev/sdX bs=1M status=progress
```

### Installing the mender image onto the eMMC
* Boot up the device using the mender sd card with 'AltBoot'.
* Wait for the Linux prompt and issue:
```
mr-deploy
```
* Wait for 'SUCCESS', then issue `cl-uboot` and select the `/dev/mmcblk2boot0` as destination:
```
cl-uboot
```
* Reboot the device, stop in U-boot, remove the sd card and issue:
```
env default -a; saveenv; reset
```
