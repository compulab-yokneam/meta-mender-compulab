# Configuring the build

## Setup Yocto environment

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Set environment variables:

Machine | Environment |
--- | --- |
`ucm-imx8m-plus` | `export MACHINE=ucm-imx8m-plus MANIFEST=mender-compulab-kirkstone.xml`

* Initialize CompuLab Yocto build environment:
<br>Follow the instructions of [meta-bsp-imx8mp](https://github.com/compulab-yokneam/meta-bsp-imx8mp/tree/ucm-imx8m-plus-r2.0)

* Initialize and sync CompuLab Mender repo manifest:
```
mkdir -p .repo/local_manifests
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/kirkstone-nxp/scripts/${MANIFEST}
repo sync
```

## Setup build environment

* Initialize the build environment:
```
source mender-setup-environment build-${MACHINE}
```
* Building the image:
```
bitbake -k fsl-image-network-full-cmdline
```
