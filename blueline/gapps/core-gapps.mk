# Core Google services for LineageOS 24.0 / Pixel 3 only.
# Keep the regular lineage-24.0 tree vanilla; never include this in that branch.
# This does not use the MindTheGapps arm64-vendor.mk, which would install
# Assistant, SetupWizard, TalkBack, Wellbeing and an EROFS-backed GMS APEX.
#
# Run the GApps-branch local-manifest build helper before invoking lunch:
# it extracts the Google Play Services APK and its bundled XML declarations.

PRODUCT_SOONG_NAMESPACES += \
    vendor/gapps/common \
    vendor/gapps/arm64 \
    device/google/crosshatch/blueline/gapps

PRODUCT_PACKAGES += \
    Phonesky \
    GoogleServicesFramework \
    GooglePartnerSetup \
    GoogleContactsSyncAdapter \
    GoogleCalendarSyncAdapter \
    HeckerGmsCoreCompat \
    default-permissions-google.xml \
    default-permissions-mtg.xml \
    google-hiddenapi-package-allowlist.xml \
    google.xml \
    privapp-permissions-google-product.xml \
    privapp-permissions-google-system_ext.xml \
    privapp-permissions-mtg.xml \
    sysconfig-mtg.xml \
    gapps.rc \
    gms_fsverity_cert.der

# The legacy 4.9 kernel cannot mount GMS's EROFS APEX. Import the APK as
# a privileged /product app and install the permissions/sysconfig from its
# extracted payload instead. Do NOT include the original GMS APEX module.
ifeq ($(wildcard device/google/crosshatch/blueline/gapps/generated/PrebuiltGmsCoreVic.apk),)
$(error GMS core APK not prepared; run bash .repo/local_manifests/build.sh --prepare-only)
endif
include device/google/crosshatch/blueline/gapps/generated/gms-permissions.mk
