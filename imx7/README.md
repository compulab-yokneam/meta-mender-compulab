# Configuring the build

## Setup Yocto environment

### Mender

* Branch
<pre>
export BRANCH="warrior"
</pre>
* WorkDir
<pre>
mkdir mender-compulab && cd mender-compulab
</pre>
* Initialize and sync repo manifest:
<pre>
repo init -u https://github.com/mendersoftware/meta-mender-community \
           -m meta-mender-nxp/scripts/manifest-nxp.xml \
           -b ${BRANCH}

repo sync
</pre>

### CompuLab

* Download CompuLab meta layer:
<pre>
git clone -b imx7 https://github.com/compulab-yokneam/meta-mender-compulab.git sources/meta-mender-compulab/
</pre>

## Setup build environment
* Initialize the build environment:
<pre>
source sources/meta-mender-compulab/imx7/tools/setup-env
</pre>

* Choose a media that the image will be used for:
<pre>
--- Users' Configurations started ---
1) default
2) sd
3) emmc
media configuration [ sd ] (Ctrl^C -- exit) :
</pre>

* Choose a security option:
<pre>
1) default
2) yes
3) no
hab configuration [ yes ] (Ctrl^C -- exit) :
</pre>

* Building the image:
<pre>
bitbake -k core-image-full-cmdline
</pre>

## Deployment
### Create an image file
* Goto the `tmp/deploy/images/cl-som-imx7` directory:
<pre>
cd tmp/deploy/images/cl-som-imx7
</pre>

* Deploy the image:
<pre>
bmaptool copy core-image-full-cmdline-cl-som-imx7.sdimg /path/to/mender.sd.img
</pre>

* Deploy the u-boot.imx:
<pre>
dd if=u-boot.imx of=/path/to/mender.sd.img bs=1k seek=1 conv=notrunc
</pre>

### Create a bootable sd card
* Deploy the image to sd card:
<pre>
sudo dd if=/path/to/mender.sd.img of=/dev/sdX bs=1M status=progress
</pre>

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
* Issue: <pre>setenv script; setenv bootscript; boot</pre>
* Let the device boot up
* While in Linux:
* If **hab=yes**, update the bootloader link:<pre>ln -fs u-boot.imx.signed /boot/u-boot.imx</pre>
* Update the bootloader:<pre>cl-uboot</pre>
* Issue:<pre>cl-deploy</pre>
* Reboot the device
* Stop in U-boot
* Remove the media
* Issue:<pre>env default -a</pre>
* If **hab=yes**, then update the kernel variable:<pre>setenev kernel zImage.signed</pre>
* Issue:<pre>saveenv; reset</pre>
* Let the device boot up
* Done.

## Fuse values
If **hab=yes**, then the fuse values file can be found at this location:
<pre>cat /boot/signed/f/fuse.out</pre>

Important | Standard CompuLab warranty does not apply if fuses are flashed |
--- | --- |

## Pre-Built image
* [core-image-full-cmdline image](https://drive.google.com/drive/folders/1ZRijCNB07aNvu3uUNTiG4YJgRuCXPYaV)

## References
* https://hub.mender.io/t/nxp-i-mx7d-sabre/1279
