# Configuring the build

## Setup Yocto environment

### Mender

* Branch
```
export BRANCH="warrior"
```
* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Initialize and sync repo manifest:
```
repo init -u https://github.com/mendersoftware/meta-mender-community \
           -m meta-mender-nxp/scripts/manifest-nxp.xml \
           -b ${BRANCH}

repo sync
```

### CompuLab

* Download CompuLab meta layer:
```
git clone -b imx7 https://github.com/compulab-yokneam/meta-mender-compulab.git sources/meta-mender-compulab/
```

## Setup build environment
* Initialize the build environment:
```
source sources/meta-mender-compulab/imx7/tools/setup-env
```

* Choose a media that the image will be used for:
```
--- Users' Configurations started ---
1) default
2) sd
3) emmc
media configuration [ sd ] (Ctrl^C -- exit) :
```

* Building the image:
```
bitbake -k core-image-full-cmdline
```

## Deployment
### Create an image file
* Goto the `tmp/deploy/images/cl-som-imx7` directory:
```
cd tmp/deploy/images/cl-som-imx7
```

* Deploy the image:
```
bmaptool copy core-image-full-cmdline-cl-som-imx7.sdimg /path/to/mender.sd.img
```

* Deploy the u-boot.imx:
```
dd if=u-boot.imx of=/path/to/mender.sd.img bs=1k seek=1 conv=notrunc
```

### Create a bootable sd card
* Deploy the image to sd card:
```
sudo dd if=/path/to/mender.sd.img of=/dev/sdX bs=1M status=progress
```

## Boot a created image
### SD

Important | An image with `media configuration sd` must be used |
--- | --- |

* Turn on the device
* Stop in U-Boot
* Insert the created sd-card
* Issue 'AltBoot' and let the device boot up
* Done.

### eMMC

Important | An image with `media configuration emmc` must be used |
--- | --- |

* Turn on the device
* Stop in U-Boot
* Insert the created sd-card
* Issue: ```setenv script; setenv bootscript; boot```
* Let the device boot up
* While in Linux issue:```cl-deploy```
* Reboot the device
* Stop in U-boot
* Remove the media
* Issue:```env default -a```
* Issue:```saveenv; reset```
* Let the device boot up
* Done.

## Pre-Built image
* [core-image-full-cmdline image](https://drive.google.com/drive/folders/1ZRijCNB07aNvu3uUNTiG4YJgRuCXPYaV)

## References
* https://hub.mender.io/t/nxp-i-mx7d-sabre/1279
