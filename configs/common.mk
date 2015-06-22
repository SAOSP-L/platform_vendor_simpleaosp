# Copyright (C) 2015 SimpleAOSP Project
# Copyright (C) 2015 ParanoidAndroid Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Brand
PRODUCT_BRAND ?= simpleaosp

# Local path for prebuilts
LOCAL_PATH:= vendor/simpleaosp/prebuilts/common/system

# Common build prop overrides 
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.android.dataroaming=false \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    keyguard.no_require_sim=true \
    ro.facelock.black_timeout=400 \
    ro.facelock.det_timeout=1500 \
    ro.facelock.rec_timeout=2500 \
    ro.facelock.lively_timeout=2500 \
    ro.facelock.est_max_time=600 \
    ro.facelock.use_intro_anim=false \
    ro.build.selinux=1

# Common overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/simpleaosp/overlays/common

# Needed Packages
PRODUCT_PACKAGES += \
LockClock \
ScreenRecorder \
libscreenrecorder \
Trebuchet

# CM Platform Library
PRODUCT_PACKAGES += \
    org.cyanogenmod.platform-res \
    org.cyanogenmod.platform \
    org.cyanogenmod.platform.xml

# Telephony packages for only telephony devices
ifneq ($(filter saosp_hammerhead saosp_mako saosp_shamu,$(TARGET_PRODUCT)),)
 PRODUCT_PACKAGES += \
     CellBroadcastReceiver \
     Stk
endif

# init.d script support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bin/sysinit:system/bin/sysinit 

# userinit support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/init.d/90userinit:system/etc/init.d/90userinit

# SU Support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
    $(LOCAL_PATH)/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon \


# Proprietary latinime lib needed for swyping
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/lib/libjni_latinime.so:system/lib/libjni_latinime.so

# Enable sip+voip on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Blobs for media effects
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/media/LMspeed_508.emd:system/vendor/media/LMspeed_508.emd \
    $(LOCAL_PATH)/vendor/media/PFFprec_600.emd:system/vendor/media/PFFprec_600.emd

# Backuptool support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/addon.d/50-simpleaosp.sh:system/addon.d/50-simpleaosp.sh \
    $(LOCAL_PATH)/bin/backuptool.functions:system/bin/backuptool.functions \
    $(LOCAL_PATH)/bin/backuptool.sh:system/bin/backuptool.sh
    
# Bootanimation enhancements
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
TARGET_BOOTANIMATION_USE_RGB565 := true

# T-Mobile theme engine
 include vendor/simpleaosp/configs/themes_common.mk

# Add few DRM libs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/lib/drm/libdrmwvmplugin.so:system/vendor/lib/drm/libdrmwvmplugin.so \
    $(LOCAL_PATH)/lib/mediadrm/libdrmclearkeyplugin.so:system/vendor/lib/mediadrm/libdrmclearkeyplugin.so \
    $(LOCAL_PATH)/lib/mediadrm/libwvdrmengine.so:system/vendor/lib/mediadrm/libwvdrmengine.so

# Get the right bootanimation for each device
ifneq ($(filter saosp_flo,$(TARGET_PRODUCT)),)
PRODUCT_BOOTANIMATION := $(LOCAL_PATH)/media/flo-bootanimation.zip
endif

ifneq ($(filter saosp_flounder,$(TARGET_PRODUCT)),)
PRODUCT_BOOTANIMATION := $(LOCAL_PATH)/media/flounder-bootanimation.zip
endif

ifneq ($(filter saosp_hammerhead,$(TARGET_PRODUCT)),)
PRODUCT_BOOTANIMATION := $(LOCAL_PATH)/media/hammerhead-bootanimation.zip
endif

ifneq ($(filter saosp_mako,$(TARGET_PRODUCT)),)
PRODUCT_BOOTANIMATION := $(LOCAL_PATH)/media/mako-bootanimation.zip
endif

ifneq ($(filter saosp_shamu,$(TARGET_PRODUCT)),)
PRODUCT_BOOTANIMATION := $(LOCAL_PATH)/media/shamu-bootanimation.zip
endif

# Include chromium prebuilt if opted in
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif
