# Configuring the build

## Prepare build environment

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Initialize and sync repo manifest:
```
repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-warrior -m imx-4.19.35-1.1.2.xml
wget --directory-prefix .repo/manifests https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/imx7-nxp/imx7/scripts/imx-4.19.35-1.1.2_demo_mender.xml
repo init -m imx-4.19.35-1.1.2_demo_mender.xml
repo sync
```

## Setup build environment
* Initialize the build environment:

Media Options | Setup command |
--- | --- |
UUID|MENDER_UUID_DEVICE=Yes source compulab-setup-env -b build-uuid|
BLOCK|MENDER_BLOCK_DEVICE=Yes source compulab-setup-env -b build-block|

* [BLOCK] Choose a media that the image will be used for:
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

[BLOCK] Important | An image with `media configuration sd` must be used |
--- | --- |

* Turn on the device
* Stop in U-Boot
* Insert the created sd-card
* Issue 'AltBoot' and let the device boot up
* Done.

### eMMC

[BLOCK] Important | An image with `media configuration emmc` must be used |
--- | --- |

* Turn on the device
* Stop in U-Boot
* Insert the created sd-card
* Issue:<pre>mw.w ${loadaddr} 0x0 0x800; mmc dev 1;mmc write ${loadaddr} 0 0x4; setenv script; setenv bootscript; boot</pre>

[BLOCK] Impotant | The very 1-st boot will be an emergency one
--- | --- |
| | The prompt will be `(or press Control-D to continue):`; press `Enter` and continue:


* Let the device boot up
* While in Linux issue:<pre>cl-uboot; cl-deploy</pre>
* Reboot the device
* Stop in U-boot
* Remove the media
* Issue:<pre>env default -a; saveenv; reset</pre>
* Let the device boot up
* Done.

## Pre-Built image
* [core-image-full-cmdline image](https://drive.google.com/file/d/1KdrE6PPfs8BC9delu9sxOLg9tONml0RL/view?usp=sharing)
