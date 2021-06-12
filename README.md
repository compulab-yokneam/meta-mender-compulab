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

* Initialize and sync repo manifest:
```
repo init -u https://github.com/Freescale/fsl-community-bsp-platform -b dunfell
wget --directory-prefix .repo/manifests https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/dunfell/scripts/mender-compulab-dunfell.xml
repo init -m mender-compulab-dunfell.xml
repo sync
```

## Setup build environment

* Initialize the build environment:
```
source compulab-setup-env build-fslc-${MACHINE}
```
* Building the image:
```
bitbake -k core-image-full-cmdline
```

## Deployment
### Create an image file
* Goto the `tmp/deploy/images/${MACHINE}` directory:
```
cd tmp/deploy/images/${MACHINE}
```

* Deploy the image to the sd card:
```
bmaptool copy core-image-full-cmdline-${MACHINE}.sdimg /dev/sdX
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
