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
`i.MX8MM` | [meta-bsp-imx8mm](https://github.com/compulab-yokneam/meta-bsp-imx8mm/tree/iot-gate-imx8_5.15.32)
`i.MX8MP` | [meta-bsp-imx8mp](https://github.com/compulab-yokneam/meta-bsp-imx8mp/tree/kirkstone-2.2.0)
`i.MX9` | [meta-bsp-imx9](https://github.com/compulab-yokneam/meta-bsp-imx9/tree/kirkstone-2.2.0)

* Initialize and sync CompuLab Mender repo manifest:

```
mkdir -p .repo/local_manifests
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/kirkstone-nxp/scripts/mender-compulab-kirkstone.xml
repo sync
```

* Set environment variables:

NXP SoC | CompuLab Machine | Environment variable |
--- | --- | --- |
`i.MX8MM`| `iot-gate-imx8` | `export MACHINE=iot-gate-imx8`
`i.MX8MP`|`iot-gate-imx8plus` | `export MACHINE=iot-gate-imx8plus`
`i.MX9`|`ucm-imx93` | `export MACHINE=ucm-imx93`

## Setup build environment

* Initialize the build environment:

```
source mender-setup-environment build-${MACHINE}
```

* Building the image:

```
bitbake -k fsl-image-network-full-cmdline
```
