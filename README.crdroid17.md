# Android 17 blueline development target

Build and source manifest:
https://github.com/its-hecker/Blueline-Crdroid-Local-Manifest

Use the matching `crdroid-17.0` device, kernel and vendor branches. The Pixel 3
product is `lineage_blueline`, already defined in this shared tree. Linux 4.9
compatibility also needs the platform patches and legacy hardware projects in
the local manifest; syncing only this device tree is insufficient.

This is a vanilla development build. The stock physical partition dimensions
are unchanged. It removes the GApps reserve, retains ext4 retrofit partitions,
file-based encryption, thermal management and SELinux enforcing. HIDL dumpstate
and power statistics are not installed; the old source remains for reference.

The camera/fingerprint/Secure UI fixups in `blueline/extract-files.py` must stay
in step with the vendor branch. Compatibility shims, ION rules and thermal
policy are adapted from xbill9's Android 17 Pixel 3a bring-up, with original
source/license headers retained. Device-specific kernel, display, camera,
thermal configurations and calibration paths remain for SDM845/blueline.

No claim of a completed full-ROM build, successful Pixel 3 boot or working
hardware should be made until the server build and device tests are performed.
