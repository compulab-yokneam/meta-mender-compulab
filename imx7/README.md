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
* Building the image:
<pre>
bitbake -k core-image-base
</pre>

## Create a bootable sd card
* Goto the `tmp/deploy/images/cl-som-imx7` directory:
<pre>
cd tmp/deploy/images/cl-som-imx7
</pre>

* Deploy the image to sd card:
<pre>
sudo bmaptool copy core-image-base-cl-som-imx7.sdimg /dev/sdX
</pre>

* Deploy the u-boot.imx to sd card:
<pre>
sudo dd if=u-boot.imx of=/dev/sdX bs=1k seek=1; sync
</pre>

## References:
* https://hub.mender.io/t/nxp-i-mx7d-sabre/1279
