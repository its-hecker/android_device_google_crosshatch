# SPDX-License-Identifier: Apache-2.0
# Match the HeckerOS native-ADB development defaults for this Pixel 3 port.
PIXEL3_DEV_USB_ADB ?= $(if $(filter userdebug eng,$(TARGET_BUILD_VARIANT)),true,false)

# Product properties load after the platform defaults. Keep one assignment here.
PRODUCT_PRODUCT_PROPERTIES := $(filter-out \
    ro.adb.secure=% ro.adb.secure?=%, \
    $(PRODUCT_PRODUCT_PROPERTIES))

ifeq ($(strip $(PIXEL3_DEV_USB_ADB)),true)
ifeq ($(filter userdebug eng,$(TARGET_BUILD_VARIANT)),)
$(error PIXEL3_DEV_USB_ADB=true requires a userdebug or eng build)
endif
PRODUCT_PRODUCT_PROPERTIES := $(filter-out \
    persist.sys.usb.config=% persist.sys.usb.config?=%, \
    $(PRODUCT_PRODUCT_PROPERTIES))
PRODUCT_PRODUCT_PROPERTIES += \
    ro.adb.secure=0 \
    persist.sys.usb.config=adb
else ifeq ($(strip $(PIXEL3_DEV_USB_ADB)),false)
# Restore normal PC authorization, including when the base eng image disables it.
PRODUCT_PRODUCT_PROPERTIES += ro.adb.secure=1
else
$(error PIXEL3_DEV_USB_ADB must be true or false)
endif
