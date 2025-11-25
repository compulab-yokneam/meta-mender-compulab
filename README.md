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
`i.MX8MM` | [meta-bsp-imx8mm](https://github.com/compulab-yokneam/meta-bsp-imx8mm/tree/rel_imx_6.6.3_1.0.0)
`i.MX8MP` | [meta-bsp-imx8mp](https://github.com/compulab-yokneam/meta-bsp-imx8mp/tree/scarthgap-2.2.0)
`i.MX91, i.MX93` | [meta-bsp-imx9](https://github.com/compulab-yokneam/meta-bsp-imx9/blob/scarthgap)
`i.MX95` | [meta-bsp-imx95](https://github.com/compulab-yokneam/meta-bsp-imx95/tree/scarthgap-6.6.52-EVAL-UCM-iMX95-2.0)

* Initialize and sync CompuLab Mender repo manifest:

```
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/scarthgap-nxp/scripts/mender-compulab.xml
repo sync
```

* Set environment variables:

NXP SoC | CompuLab Machine | Environment variable |
--- | --- | --- |
`i.MX8MM`|`iot-gate-imx8`|`export MACHINE=iot-gate-imx8`
`i.MX8MM`|`ucm-imx8m-mini`|`export MACHINE=ucm-imx8m-mini`
`i.MX8MP`|`iot-gate-imx8plus`|`export MACHINE=iot-gate-imx8plus`
`i.MX8MP`|`iotdin-imx8p`|`export MACHINE=iotdin-imx8p`
`i.MX8MP`|`som-imx8m-plus`|`export MACHINE=som-imx8m-plus`
`i.MX8MP`|`ucm-imx8m-plus`|`export MACHINE=ucm-imx8m-plus`
`i.MX8MP`|`ucm-imx8m-plus-sbev`|`export MACHINE=ucm-imx8m-plus-sbev`
`i.MX91`|`ucm-imx91`|`export MACHINE=ucm-imx91`
`i.MX93`|`ucm-imx93`|`export MACHINE=ucm-imx93`
`i.MX93`|`mcm-imx93`|`export MACHINE=mcm-imx93`
`i.MX95`|`ucm-imx95`|`export MACHINE=ucm-imx95`

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
