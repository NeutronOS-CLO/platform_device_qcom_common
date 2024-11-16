# Include display HAL makefiles.
ifeq ($(TARGET_FWK_SUPPORTS_FULL_VALUEADDS),true)
include vendor/qcom/opensource/commonsys-intf/display/config/display-interfaces-product.mk
include vendor/qcom/opensource/commonsys-intf/display/config/display-product-system.mk
include vendor/qcom/opensource/commonsys/display/config/display-product-commonsys.mk
endif

include hardware/qcom/display/config/display-board.mk
include hardware/qcom/display/config/display-product.mk

# Include QTI AIDL Lights HAL
include vendor/qcom/opensource/lights/lights-vendor-product.mk

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# Packages
PRODUCT_PACKAGES += \
    android.hardware.graphics.common-V1-ndk \
    android.hardware.graphics.common-V1-ndk.vendor \
    libqdutils \
    libqservice

# Properties for <5.15 targets
# These are already set on 5.15+.
ifneq (,$(filter 3.18 4.4 4.9 4.14 4.19 5.4 5.10, $(TARGET_KERNEL_VERSION)))
PRODUCT_VENDOR_PROPERTIES += \
    debug.sf.auto_latch_unsignaled=0
endif

# Properties for <5.10 targets
# These are already set on 5.10+.
ifneq (,$(filter 3.18 4.4 4.9 4.14 4.19 5.4, $(TARGET_KERNEL_VERSION)))
PRODUCT_VENDOR_PROPERTIES += \
    debug.sf.predict_hwc_composition_strategy=0 \
    debug.sf.treat_170m_as_sRGB=1

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.game_default_frame_rate_override=60
endif

# Properties for <5.4 targets
# These are already set on 5.4+
ifneq (,$(filter 3.18 4.4 4.9 4.14 4.19, $(TARGET_KERNEL_VERSION)))
PRODUCT_VENDOR_PROPERTIES += \
    debug.sf.disable_client_composition_cache=1
endif

# Properties for <4.19 targets
# These are already set on 4.19+.
ifneq (,$(filter 3.18 4.4 4.9 4.14, $(TARGET_KERNEL_VERSION)))
PRODUCT_VENDOR_PROPERTIES += \
    debug.sf.latch_unsignaled=1
endif

# Disable custom content metadata region on <5.15 targets
ifneq (,$(filter 3.18 4.4 4.9 4.14 4.19 5.4 5.10, $(TARGET_KERNEL_VERSION)))
TARGET_GRALLOC_HANDLE_HAS_NO_CUSTOM_CONTENT_MD_RESERVED_SIZE := true
endif

# Disable UBWC-P on <6.1 targets
ifneq (,$(filter 3.18 4.4 4.9 4.14 4.19 5.4 5.10 5.15, $(TARGET_KERNEL_VERSION)))
TARGET_GRALLOC_HANDLE_HAS_NO_UBWCP := true
endif
