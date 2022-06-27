# Configuring the build

## Setup Yocto environment

* WorkDir
```
mkdir mender-compulab && cd mender-compulab
```
* Set environment variables:

Variable | Command to set |
--- | --- |
`MACHINE`| `MACHINE=ucm-imx8m-plus` |
`MANIFEST`| `MANIFEST=mender-compulab-kirkstone.xml` |

* Initialize FSL comunity & CompuLab repo manifests:
Follow the instructions of [compulab-fslc-bsp](https://github.com/compulab-yokneam/compulab-fslc-bsp/tree/kirkstone#initialize-repo-manifests)

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
