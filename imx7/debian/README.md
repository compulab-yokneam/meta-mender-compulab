# Debian Helper Layer

## Purpose
Addresses the mender dependency issues with the Debian distros.
Must be used for these packages only:
* warrior: `mender mender-connect mender-configure glib-2.0 dbus`
* gatesgarth: `mender-client mender-connect mender-configure glib-2.0 dbus`

## How to use

* Update the conf/bblayer.conf; add this line to:
```
BBLAYERS += "${BSPDIR}/sources/meta-mender-compulab/debian"
```

* Issue this command for the very 1-st time; it cleans up all packages:
```
bitbake -k mender mender-connect mender-configure glib-2.0 dbus -c cleansstate
```

* Issue this command for creating new packages with this layer included:
```
bitbake -k mender mender-connect mender-configure glib-2.0 dbus

```
| WARNING|This layer must be removed from the conf/bblayer.conf for the entire image build.
|---|---|
