# Configuring the build

## Setup Yocto environment

* WorkDir

```
mkdir mender-compulab && cd mender-compulab
```

* CompuLab Yocto build environment</br>
Follow the instructions of the specific machine and prepare the Yocto Build environemt:

NXP SoC | Build Environment Manual|
--- | --- |
`i.MX8MP` | [meta-bsp-imx8mp](https://github.com/compulab-yokneam/meta-bsp-imx8mp/tree/walnascar)

* Initialize and sync CompuLab Mender repo manifest:

```
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/walnascar/scripts/mender-compulab.xml
repo sync
```

* Set environment variables:

NXP SoC | CompuLab Machine | Environment variable |
--- | --- | --- |
`i.MX8MP`|`iot-gate-imx8plus`|`export MACHINE=iot-gate-imx8plus`
`i.MX8MP`|`iotdin-imx8p`|`export MACHINE=iotdin-imx8p`
`i.MX8MP`|`som-imx8m-plus`|`export MACHINE=som-imx8m-plus`
`i.MX8MP`|`ucm-imx8m-plus`|`export MACHINE=ucm-imx8m-plus`
`i.MX8MP`|`ucm-imx8m-plus-sbev`|`export MACHINE=ucm-imx8m-plus-sbev`

## Setup build environment

* Initialize the build environment:

```
source mender-setup-environment build-mender-${MACHINE}
```

* Building the image:

```
bitbake -k fsl-image-network-full-cmdline
```

## Deployment

### Create a bootable media
* Goto the `tmp/deploy/images/${MACHINE}` directory:
```
cd tmp/deploy/images/${MACHINE}
```

* Deploy the image to either sd or usb media:
```
sudo bmaptool copy --bmap fsl-image-network-full-cmdline-${MACHINE}.sdimg.bmap fsl-image-network-full-cmdline-${MACHINE}.sdimg.bz2 /dev/sdX
```

### Installing the mender image onto the eMMC
* Boot up the device using the created media.
* Wait for the Linux prompt and issue:
```
cl-deploy
```
* Wait for 'SUCCESS', then reboot the device.
```
reboot
```
* Stop in U-boot, remove the installation media and issue:
```
env default -a; saveenv; reset
```
