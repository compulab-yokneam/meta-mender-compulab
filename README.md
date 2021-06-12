# Configuring the build

## Setup Yocto environment

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Set a CompuLab machine:

CompuLab machine | UCM-iMX8M-Mini | MCM-iMX8M-Mini | iot-gate-imx8 |
--- | --- | --- | --- |
`MACHINE` environment setting| `MACHINE=ucm-imx8m-mini` |`MACHINE=mcm-imx8m-mini` |`MACHINE=iot-gate-imx8` |

## Initialize repo manifests

* FSL Community
```
repo init -u https://github.com/Freescale/fsl-community-bsp-platform -b dunfell
```

* Mender
```
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/mendersoftware/meta-mender-community/dunfell/scripts/mender-no-setup.xml
```

* CompuLab FSLC & Mender
```
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/compulab-fslc-bsp/master/scripts/compulab-bsp-setup.xml
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/dunfell/scripts/mender-compulab-only.xml
```

* Sync Them all
```
repo sync
```

## Setup build environment

* Initialize the build environment:
```
source sources/meta-mender-compulab/tools/setup-env build-fslc-${MACHINE}
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
* Wait for 'SUCCESS', then reboot the device.
```
reboot
```
* Stop in U-boot, remove the sd card and issue:
```
env default -a; saveenv; reset
```
