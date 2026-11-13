#
# Copyright (C) 2018-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

include device/google/crosshatch/BoardConfigLineage.mk

include vendor/google/blueline/BoardConfigVendor.mk

# LineageOS 24.0 diagnostic builds do not currently emit the block map files
# expected by the one-time retrofit-dynamic-partitions OTA generator.
# Keep dynamic partitions and normal A/B OTA packaging enabled, but skip
# this separate retrofit-only package to avoid a packaging-stage failure.
BOARD_BUILD_RETROFIT_DYNAMIC_PARTITIONS_OTA_PACKAGE := false
