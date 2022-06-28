# Configuring the build

## Setup Yocto environment

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Set environment variables:

Machine | Environment |
--- | --- |
`iot-gate-imx8`  | `export MACHINE=iot-gate-imx8 MANIFEST=mender-compulab-kirkstone.xml`
`ucm-imx8m-plus` | `export MACHINE=ucm-imx8m-plus MANIFEST=mender-compulab-kirkstone.xml`

* Initialize FSL comunity & CompuLab repo manifests
<br>Follow the instructions of [compulab-fslc-bsp](https://github.com/compulab-yokneam/compulab-fslc-bsp/tree/kirkstone#initialize-repo-manifests)

* Initialize and sync CompuLab Mender repo manifest:
```
mkdir -p .repo/local_manifests
wget --directory-prefix .repo/local_manifests https://raw.githubusercontent.com/compulab-yokneam/meta-mender-compulab/kirkstone/scripts/${MANIFEST}
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

## Ready to run images

Machine | Image location |
--- | --- |
ucm-imx8m-plus| [fsl-image-network-full-cmdline-ucm-imx8m-plus](https://drive.google.com/drive/folders/16DPTNdd6Xrw4SOaTygpNABTfPQo7dHR7)
iot-gate-imx8| [fsl-image-network-full-cmdline-iot-gate-imx8](https://drive.google.com/drive/folders/1KTiCyZ_ngQwKoH1WikYEhOok-O0_KCcc)
