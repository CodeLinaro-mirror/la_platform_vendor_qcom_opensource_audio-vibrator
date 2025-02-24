ENABLE_AUDIO_VIB := true
ifeq ($(TARGET_USES_QMAA), true)
ifneq ($(TARGET_USES_QMAA_OVERRIDE_AUDIO), true)
ENABLE_AUDIO_VIB := false
endif
endif

ifeq ($(ENABLE_AUDIO_VIB), true)
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_C_INCLUDES += vendor/qcom/opensource/pal/inc
LOCAL_C_INCLUDES += vendor/qcom/proprietary/args/
LOCAL_MODULE := vendor.qti.hardware.audiovibrator.impl
LOCAL_CFLAGS        := $(COMMON_CFLAGS) -Wall -Werror
LOCAL_VENDOR_MODULE := true
LOCAL_SRC_FILES := \
    AudioVibrator.cpp

LOCAL_HEADER_LIBRARIES := \
    libarpal_headers \
    libspf-headers \
    libcapiv2_headers \
    libagm_headers \
    libacdb_headers \
    liblisten_headers \
    libarosal_headers

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    liblog \
    libsoc_helper \
    libbinder_ndk \
    android.hardware.vibrator-V2-ndk \
    libpalclient

LOCAL_EXPORT_C_INCLUDE_DIRS += $(LOCAL_PATH)/include

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_USE_VNDK := true

LOCAL_MODULE := vendor.qti.hardware.audiovibrator.service
LOCAL_CFLAGS        := $(COMMON_CFLAGS) -Wall -Werror
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_VENDOR_MODULE := true
LOCAL_INIT_RC := vendor.qti.hardware.audiovibrator.service.rc
LOCAL_VINTF_FRAGMENTS := vendor.qti.hardware.audiovibrator.service.xml
LOCAL_SRC_FILES := \
         service.cpp

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    libbase \
    libbinder_ndk \
    vendor.qti.hardware.audiovibrator.impl \
    android.hardware.vibrator-V2-ndk

include $(BUILD_EXECUTABLE)
endif # ENABLE_AUDIO_VIB
