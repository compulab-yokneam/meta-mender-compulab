# Configuring the build

## Setup Yocto environment

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Set a CompuLab machine:

CompuLab machine | UCM-iMX8M-Plus |
--- | --- |
`MACHINE` environment setting| `MACHINE=ucm-imx8m-plus` |
`MANIFEST` environment setting| `MANIFEST=mender-compulab-gatesgarth.xml` |

* Initialize and sync repo manifest:
```
repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-gatesgarth -m imx-5.10.9-1.0.0.xml
wget --output-document=.repo/manifests/mender-compulab.xml https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/gatesgarth/scripts/${MANIFEST}
repo init -m mender-compulab.xml
repo sync
```

## Setup build environment

* Initialize the build environment:
```
source mender-setup-env build-${MACHINE}
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
