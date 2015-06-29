# Inherit AOSP device configuration for mako
$(call inherit-product, device/htc/flounder/aosp_flounder.mk)

# Inherit common product files
$(call inherit-product, vendor/simpleaosp/configs/common.mk)

# Setup device specific product configuration
PRODUCT_NAME := saosp_flounder
PRODUCT_BRAND := google
PRODUCT_DEVICE := flounder
PRODUCT_MODEL := Nexus 9
PRODUCT_MANUFACTURER := htc

# Build prop fingerprint overrides
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME="volantis" BUILD_FINGERPRINT="google/volantis/flounder:5.1.1/LYZ28E/1914015:user/release-keys" PRIVATE_BUILD_DESC="volantis-user 5.1.1 LYZ28E 1914015 release-keys"
