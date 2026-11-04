#
# Copyright (C) 2018-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image.lz4
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_CLANG_VERSION := r416183b
TARGET_KERNEL_CLANG_PATH := $(abspath .)/prebuilts/clang/kernel/$(HOST_PREBUILT_TAG)/clang-$(TARGET_KERNEL_CLANG_VERSION)
TARGET_KERNEL_CONFIG := b1c1_defconfig
TARGET_KERNEL_LLVM_BINUTILS := false
# Linux 4.9 uses GNU gold for full LTO; Android 17 no longer supplies these defaults.
KERNEL_CC := CC=clang
KERNEL_CROSS_COMPILE := \
    CROSS_COMPILE=$(abspath .)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- \
    CROSS_COMPILE_ARM32=$(abspath .)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-4.9/bin/arm-linux-androideabi- \
    HOSTCC=$(TARGET_KERNEL_CLANG_PATH)/bin/clang \
    HOSTCXX=$(TARGET_KERNEL_CLANG_PATH)/bin/clang++ \
    HOSTLD=$(TARGET_KERNEL_CLANG_PATH)/bin/ld.lld \
    HOSTAR=$(TARGET_KERNEL_CLANG_PATH)/bin/llvm-ar
TARGET_KERNEL_SOURCE := kernel/google/msm-4.9
TARGET_NEEDS_DTBOIMAGE := true

# Partitions
AB_OTA_PARTITIONS += \
    vendor
ifneq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
    BOARD_VENDORIMAGE_PARTITION_SIZE := 805306368
endif
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Vanilla-only port: use the existing retrofit group without a GApps reserve.
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 0
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 0
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 0
BOARD_EXT4_SHARE_DUP_BLOCKS := true

# SELinux
BOARD_SEPOLICY_DIRS += device/google/crosshatch/sepolicy-lineage/dynamic
BOARD_SEPOLICY_DIRS += device/google/crosshatch/sepolicy-lineage/vendor

# Verified Boot
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
