LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_JAVA_LIBRARIES := bouncycastle telephony-common
LOCAL_STATIC_JAVA_LIBRARIES := guava android-support-v4 jsr305

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(call all-java-files-under, src)

BLUETOOTH_SRC := \
        src/com/android/settings/bluetooth \

BLUETOOTH_MSM_SRC := \
        src/com/android/settings/bluetooth_msm \

ifeq ($(BOARD_HAVE_BLUETOOTH_BLUEZ), true)
    LOCAL_SRC_FILES := $(filter-out \
                        $(call find-other-java-files, $(BLUETOOTH_SRC)) \
                        ,$(LOCAL_SRC_FILES))
else
    LOCAL_SRC_FILES := $(filter-out \
                        $(call find-other-java-files, $(BLUETOOTH_MSM_SRC)) \
                        ,$(LOCAL_SRC_FILES))
endif


LOCAL_PACKAGE_NAME := Settings
LOCAL_CERTIFICATE := platform

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_AAPT_INCLUDE_ALL_RESOURCES := true
LOCAL_AAPT_FLAGS := --extra-packages com.koushikdutta.superuser:com.koushikdutta.widgets -S $(LOCAL_PATH)/../../../external/koush/Widgets/Widgets/res -S $(LOCAL_PATH)/../../../external/koush/Superuser/Superuser/res --auto-add-overlay

LOCAL_SRC_FILES += $(call all-java-files-under,../../../external/koush/Superuser/Superuser/src) $(call all-java-files-under,../../../external/koush/Widgets/Widgets/src)

include $(BUILD_PACKAGE)

# Use the folloing include to make our test apk.
include $(call all-makefiles-under,$(LOCAL_PATH))
