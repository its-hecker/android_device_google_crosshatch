#
# Copyright (C) 2018-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Unofficial vanilla LineageOS 24.0 / Android 17 for Pixel 3.

# Pixel 3's userdebug bring-up needs the Lineage debug *build* switch, not
# just USB properties.  Without it Lineage's common.mk sets
# PRODUCT_NOT_DEBUGGABLE_IN_USERDEBUG=true and ro.adb.secure=1, leaving adbd
# disabled despite the persist.sys.usb.config=adb image default.
# Resolve this before inheriting vendor/lineage/config/common_full_phone.mk.
PIXEL3_DEV_USB_ADB ?= $(if $(filter userdebug eng,$(TARGET_BUILD_VARIANT)),true,false)
ifeq ($(strip $(PIXEL3_DEV_USB_ADB)),true)
ifeq ($(filter userdebug eng,$(TARGET_BUILD_VARIANT)),)
$(error PIXEL3_DEV_USB_ADB=true requires a userdebug or eng build)
endif
WITH_ADB_INSECURE := true
else ifeq ($(strip $(PIXEL3_DEV_USB_ADB)),false)
# Restore normal Lineage defaults when explicitly disabled.
WITH_ADB_INSECURE :=
else
$(error PIXEL3_DEV_USB_ADB must be true or false)
endif

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/google/crosshatch/aosp_blueline.mk)

include device/google/crosshatch/blueline/device-lineage.mk

# Device identifier. This must come after all inclusions
PRODUCT_BRAND := google
PRODUCT_MODEL := Pixel 3
PRODUCT_NAME := lineage_blueline

# Boot animation
TARGET_SCREEN_HEIGHT := 2160
TARGET_SCREEN_WIDTH := 1080

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="blueline-user 12 SP1A.210812.016.C2 8618562 release-keys" \
    BuildFingerprint=google/blueline/blueline:12/SP1A.210812.016.C2/8618562:user/release-keys \
    DeviceProduct=blueline

$(call inherit-product, vendor/google/blueline/blueline-vendor.mk)

# Development USB debugging defaults for the Pixel 3 port.
include device/google/crosshatch/development/adb.mk
