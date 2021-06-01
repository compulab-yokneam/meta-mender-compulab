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
### Create a bootable sd card
* Goto the `tmp/deploy/images/cl-som-imx7` directory:
```
cd tmp/deploy/images/cl-som-imx7
```

* Deploy the image to the sd card:
```
bmaptool copy core-image-full-cmdline-cl-som-imx7.sdimg /dev/sdX
```

## Boot the created image
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
* Wipe out the internal media partition table, issue:<pre>mw.w ${loadaddr} 0x0 0x800; mmc dev 1;mmc write ${loadaddr} 0 0x4</pre>
* Make the device ignore the default boot script, issue:<pre>setenv script; setenv bootscript; reset</pre>
* Let the device boot up

[BLOCK] Impotant | The very 1-st boot will be an emergency one
--- | --- |
| | The prompt will be `(or press Control-D to continue):`; press `Enter` and continue:

* While in Linux issue:<pre>mr-deploy</pre>
* Reboot the device
* Stop in U-boot
* Remove the media
* Issue:<pre>env default -a; saveenv; reset</pre>
* Let the device boot up
* Done.

## Pre-Built image
* [core-image-full-cmdline image  uuid](https://drive.google.com/file/d/1uFMYmxD7_7UMZkD1bsfrwK09v0ViwYsZ/view?usp=sharing)
* [core-image-full-cmdline image block](https://drive.google.com/file/d/1qRE747jViclcezYrbMr5GVdeaPgw4fo4/view?usp=sharing)
