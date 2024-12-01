#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/samsung/a55x

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Enable developer GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true
	
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd 

PRODUCT_PACKAGES += \
    bootctrl.erd8845

PRODUCT_PACKAGES += \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Recovery additional binaries
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libxml2

# Shipping level
PRODUCT_SHIPPING_API_LEVEL := 32

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
	
PRODUCT_PACKAGES += \
    fstab.s5e8845 \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.s5e8845:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.s5e8845 \
    $(LOCAL_PATH)/rootdir/etc/fstab.s5e8845:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.s5e8845 \
    $(LOCAL_PATH)/prebuilt/platform/vangogh_lite_unified_evt0.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/lib/firmware/sgpu/vangogh_lite_unified_evt0.bin \
    $(LOCAL_PATH)/prebuilt/platform/vangogh_lite_unified_evt0.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/firmware/sgpu/vangogh_lite_unified_evt0.bin \
    $(LOCAL_PATH)/prebuilt/platform/gt9895_a55x.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/tsp/gt9895_a55x.bin