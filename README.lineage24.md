# LineageOS 24.0 / Android 17 for Pixel 3

Build this branch with the matching local manifest and helper:
https://github.com/its-hecker/Blueline-Crdroid-Local-Manifest

This is an unofficial vanilla `lineage_blueline` development target. The shared
crosshatch tree contains the Pixel 3 device definition; the manifest selects
Pixel 3 vendor blobs, not the Pixel 3 XL or Pixel 3a vendor.

The branch starts from `crdroid-17.0` commit
`0218f07f28aa903abf2fbd96f49763ec6c05e913`, preserving its Android 17 HAL,
legacy Qualcomm, thermal, encryption, retrofit partition and SELinux work.
Only the target description and build documentation change for LineageOS.

Use `bash .repo/local_manifests/build.sh` from the source root. The helper
applies this tree's blob fixups to the synced Pixel 3 vendor repository and
regenerates its build definitions before compiling. The manifest also supplies
the required 4.9-kernel platform compatibility forks, legacy hardware and
GNU binutils; syncing only this device repository is insufficient.

The kernel source is `kernel/google/msm-4.9`, with `b1c1_defconfig`; a Pixel 3a
kernel config or Pixel 4 kernel must not be substituted. The exact platform
source pins and default-job/RBE commands are documented in the manifest repo.

A complete Pixel 3 ROM build, successful boot and working hardware have not
been verified. Pixel 3a tests in inherited upstream documentation are not
Pixel 3 validation. Original upstream copyright and license headers are kept.
