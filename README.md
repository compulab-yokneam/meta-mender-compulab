# Configuring the build

## Setup Yocto environment

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Set a CompuLab machine:
```
MACHINE=iot-gate-imx8
LREPO=mender-compulab-setup-iot.xml
```

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
wget https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/zeus_iot-gate-imx8_1.1/scripts/${LREPO}
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
bitbake -k core-image-full-cmdline
```

## Deployment
### Create a Live Mender USB FLASH drive
* Plug a USB flash drive into the host PC.
The USB flash drive device is referred as /dev/sdX.
* Deploy the mender image to a USB FLASH drive:
```
sudo dd if=tmp/deploy/images/iot-gate-imx8/core-image-full-cmdline-iot-gate-imx8.sdimg of=/dev/sdX bs=1M status=progress
```
* Un-plug the USB flash drive from the host PC.
### Installing the mender image onto the eMMC
* Boot up the device using the Live Mender FLASH drive.
* Wait (~2 minutes) for the following messagea:
```
Press Enter for maintenance
(or press Control-D to continue):
```
* Press Enter
* Apply the following command:
```
MR_SRC=sda mr-deploy
```
* Wait for 'SUCCESS', then reboot the device.
```
reboot
```
* Stop in U-boot, remove the Live FLASH drive and issue:
```
env default -a; saveenv; reset
```
