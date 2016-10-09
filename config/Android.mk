# Copyright 2016, Sungsit Sawaiwan (fontuni.com | uni@fontuni.com).
#
# This Font Software is licensed under the SIL Open Font License, Version 1.1.
# This license is copied below, and is also available with a FAQ at:
# http://scripts.sil.org/OFL

#
# Add custom fonts.xml (config file)
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := fonts.xml
LOCAL_MODULE_CLASS := ETC
# This will install the file in /system/etc
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

