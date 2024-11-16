QCOM_COMMON_PATH := device/qcom/common

include $(QCOM_COMMON_PATH)/utils.mk

TARGET_CLO_HALS := \
    audio \
    av \
    bluetooth \
    display \
    media \
    nfc \
    wlan

$(warning "Adding qc_hals ---------------------------------------------------------")
$(warning Checking is-board-platform-in-list: $(call is-board-platform-in-list, $(4_4_FAMILY) $(4_9_FAMILY) $(4_14_FAMILY) $(4_19_FAMILY) $(5_4_FAMILY)))

ifneq (,$(filter audio, $(TARGET_CLO_HALS)))
  include $(QCOM_COMMON_PATH)/qc_audio.mk
endif

ifneq (,$(filter av, $(TARGET_CLO_HALS)))
  include $(QCOM_COMMON_PATH)/qc_av.mk
endif

ifneq (,$(filter bt, $(TARGET_CLO_HALS)))
  include $(QCOM_COMMON_PATH)/qc_bluetooth.mk
endif

ifneq (,$(filter display, $(TARGET_CLO_HALS)))
  include $(QCOM_COMMON_PATH)/qc_display.mk
endif

ifneq (,$(filter media, $(TARGET_CLO_HALS)))
  ifeq ($(call is-board-platform-in-list,$(4_4_FAMILY) $(4_9_FAMILY) $(4_14_FAMILY) $(4_19_FAMILY)),true)
    TARGET_MEDIA_COMPONENT_VARIANT ?= media-legacy
  else ifeq ($(call is-board-platform-in-list,$(5_4_FAMILY)),true)
    TARGET_MEDIA_COMPONENT_VARIANT ?= media-5.4
$(warning "Adding media-5.4 ---------------------------------------------------------")
  else
    TARGET_MEDIA_COMPONENT_VARIANT ?= media
  endif
  include $(QCOM_COMMON_PATH)/vendor/$(TARGET_MEDIA_COMPONENT_VARIANT)/qc-$(TARGET_MEDIA_COMPONENT_VARIANT).mk

  PRODUCT_COPY_FILES += \
    $(QCOM_COMMON_PATH)/vendor/seccomp/codec2.software.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.software.ext.policy \
    $(QCOM_COMMON_PATH)/vendor/seccomp/codec2.vendor.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.vendor.ext.policy \
    $(QCOM_COMMON_PATH)/vendor/seccomp/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(QCOM_COMMON_PATH)/vendor/seccomp/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy
endif

ifneq (,$(filter wlan, $(TARGET_CLO_HALS)))
  ifeq ($(call is-board-platform-in-list,$(4_4_FAMILY) $(4_9_FAMILY) $(4_14_FAMILY) $(4_19_FAMILY) $(5_4_FAMILY)),true)
    TARGET_WLAN_COMPONENT_VARIANT ?= wlan-legacy
$(warning "Adding wlan-legacy ---------------------------------------------------------")
  else
    TARGET_WLAN_COMPONENT_VARIANT ?= wlan
  endif
  include $(QCOM_COMMON_PATH)/vendor/$(TARGET_WLAN_COMPONENT_VARIANT)/qc-$(TARGET_WLAN_COMPONENT_VARIANT).mk
endif

#ifeq ($(TARGET_FWK_SUPPORTS_FULL_VALUEADDS),true)
#ifeq (,$(filter 4.4 4.9 4.14 4.19 5.4, $(TARGET_KERNEL_VERSION)))
#  include $(QCOM_COMMON_PATH)/dlkm/qti-dlkm.mk
#endif
#endif
