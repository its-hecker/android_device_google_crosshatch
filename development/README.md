# Pixel 3 development USB debugging

The `lineage_blueline` product uses the same native ADB property approach as
HeckerOS coral. `userdebug` and `eng` builds default to:

- `ro.adb.secure=0`: accept USB-connected computers without the RSA prompt.
- `persist.sys.usb.config=adb`: enable USB debugging as the initial USB default.

The build helper already selects `userdebug`, so its normal build command
enables this mode. The fragment is included only by `lineage_blueline.mk`.
A `user` build defaults to normal authorization and rejects an explicit attempt
to enable this development mode.

These are image defaults, not init commands that re-enable debugging on every
boot. Android's saved persistent USB configuration takes precedence, including
after a dirty flash. If USB debugging was disabled on existing data, enable it
before testing a new build. Turning it off remains available in Developer
options.

To restore normal PC authorization in a rebuilt image:

```bash
PIXEL3_DEV_USB_ADB=false bash .repo/local_manifests/build.sh
```

This keeps the base USB defaults; it does not erase saved settings. The mode
changes only USB debugging defaults and authorization. It does not enable
wireless/TCP ADB or ADB root and does not change SELinux.

After flashing, check from the computer:

```bash
adb devices
adb shell getprop ro.adb.secure
adb shell getprop persist.sys.usb.config
```

With fresh data and development defaults, expect `device`, `0` and a USB
configuration containing `adb`, respectively.

Capture a framework boot-loop log with:

```bash
adb wait-for-device
adb logcat -b all -v threadtime > pixel3-bootloop.txt
```

ADB can help once Android init, adbd and the USB stack are running. Kernel or
earlier boot failures can occur before ADB becomes available. The native USB
and saved-setting behavior still needs verification on the Pixel 3.
