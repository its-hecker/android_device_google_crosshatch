# SPDX-License-Identifier: Apache-2.0
# USB default for Pixel 3 development builds. Authorization and ro.debuggable
# must be set by Lineage's WITH_ADB_INSECURE switch BEFORE common.mk is loaded;
# see lineage_blueline.mk. Do not duplicate ro.adb.secure in product properties.
PIXEL3_DEV_USB_ADB ?= $(if $(filter userdebug eng,$(TARGET_BUILD_VARIANT)),true,false)

ifeq ($(strip $(PIXEL3_DEV_USB_ADB)),true)
ifeq ($(filter userdebug eng,$(TARGET_BUILD_VARIANT)),)
$(error PIXEL3_DEV_USB_ADB=true requires a userdebug or eng build)
endif
PRODUCT_PRODUCT_PROPERTIES := $(filter-out \
    persist.sys.usb.config=% persist.sys.usb.config?=%, \
    $(PRODUCT_PRODUCT_PROPERTIES))
PRODUCT_PRODUCT_PROPERTIES += persist.sys.usb.config=adb
else ifeq ($(strip $(PIXEL3_DEV_USB_ADB)),false)
# Rely on Lineage's normal secure ADB defaults; avoid conflicting ro.* values.
else
$(error PIXEL3_DEV_USB_ADB must be true or false)
endif
