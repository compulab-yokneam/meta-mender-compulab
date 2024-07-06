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
`i.MX8MP` | [meta-bsp-imx8mp](https://github.com/compulab-yokneam/meta-bsp-imx8mp/tree//scarthgap)

* Initialize and sync CompuLab Mender repo manifest:

```
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/scarthgap-nxp/scripts/mender-compulab.xml
repo sync
```

* Set environment variables:

NXP SoC | CompuLab Machine | Environment variable |
--- | --- | --- |
`i.MX8MP`|`iot-gate-imx8plus`|`export MACHINE=iot-gate-imx8plus`
`i.MX8MP`|`iotdin-imx8p`|`export MACHINE=iotdin-imx8p`
`i.MX8MP`|`ucm-imx8m-plus`|`export MACHINE=ucm-imx8m-plus`
`i.MX8MP`|`ucm-imx8m-plus-sbev`|`export MACHINE=ucm-imx8m-plus-sbev`

## Setup build environment

* Initialize the build environment:

```
source mender-setup-environment build-${MACHINE}
```

* Building the image:

```
bitbake -k fsl-image-network-full-cmdline
```
