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
`LREPO` environment setting | `LREPO=mender-compulab-setup.xml` |`LREPO=mender-compulab-setup.xml` |`LREPO=mender-compulab-setup-iot.xml` |

## Initialize repo manifests

* NXP
```
repo init -u https://github.com/nxp-imx/imx-manifest.git -b imx-linux-zeus -m imx-5.4.24-2.1.0.xml
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
wget https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/zeus/scripts/${LREPO}
cd -
```

* Sync Them all
```
repo sync
cd .repo/local_manifests
ln -sf ../../sources/meta-mender-community/scripts/mender-no-setup.xml .
ln -sf ../../sources/meta-mender-compulab/scripts/${LREPO} .
cd -
```

## Setup build environment

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
* Wait for 'SUCCESS', then reboot the device.
```
reboot
```
* Stop in U-boot, remove the sd card and issue:
```
env default -a; saveenv; reset
```
