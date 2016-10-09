# Copyright 2016, Sungsit Sawaiwan (fontuni.com | uni@fontuni.com).
#
# This Font Software is licensed under the SIL Open Font License, Version 1.1.
# This license is copied below, and is also available with a FAQ at:
# http://scripts.sil.org/OFL

# We have to use BUILD_PREBUILT instead of PRODUCT_COPY_FIES,
# because MINIMAL_FONT_FOOTPRINT is only available in Android.mks.

LOCAL_PATH := $(call my-dir)

##########################################
# create symlink for given font
# $(1): new font $(2): link target
# should be used with eval: $(eval $(call ...))
define create-font-symlink
$(PRODUCT_OUT)/system/fonts/$(1) : $(PRODUCT_OUT)/system/fonts/$(2)
	@echo "Symlink: $$@ -> $$<"
	@mkdir -p $$(dir $$@)
	@rm -rf $$@
	$(hide) ln -sf $$(notdir $$<) $$@
# this magic makes LOCAL_REQUIRED_MODULES work
ALL_MODULES.$(1).INSTALLED := \
    $(ALL_MODULES.$(1).INSTALLED) $(PRODUCT_OUT)/system/fonts/$(1)
endef

# Build the rest of font files as prebuilt.
# $(1): The source file name in LOCAL_PATH.
#       It also serves as the module name and the dest file name.
define build-one-font-module
$(eval include $(CLEAR_VARS))\
$(eval LOCAL_MODULE := $(1))\
$(eval LOCAL_SRC_FILES := $(1))\
$(eval LOCAL_MODULE_CLASS := ETC)\
$(eval LOCAL_MODULE_TAGS := optional)\
$(eval LOCAL_MODULE_PATH := $(TARGET_OUT)/fonts)\
$(eval include $(BUILD_PREBUILT))
endef

font_src_files := \
    Boon-Regular.ttf \
    Boon-Bold.ttf \
    Boon-Italic.ttf \
    Boon-BoldItalic.ttf

ifeq ($(MINIMAL_FONT_FOOTPRINT),true)

$(eval $(call create-font-symlink,Boon-SemiBold.ttf,Boon-Bold.ttf))
$(eval $(call create-font-symlink,Boon-SemiBoldItalic.ttf,Boon-BoldItalic.ttf))
$(eval $(call create-font-symlink,Boon-Light.ttf,Boon-Regular.ttf))
$(eval $(call create-font-symlink,Boon-LightItalic.ttf,Boon-Italic.ttf))
$(eval $(call create-font-symlink,Boon-Medium.ttf,Boon-Regular.ttf))
$(eval $(call create-font-symlink,Boon-MediumItalic.ttf,Boon-Italic.ttf))

else # !MINIMAL_FONT
font_src_files += \
    Boon-SemiBold.ttf \
    Boon-SemiBoldItalic.ttf \
    Boon-Light.ttf \
    Boon-LightItalic.ttf \
    Boon-Medium.ttf \
    Boon-MediumItalic.ttf

endif # !MINIMAL_FONT

# Add custom fonts.xml
#$(eval $(call add-prebuilt-files, $(PRODUCT_OUT)/system/etc/, fonts.xml))

PRODUCT_COPY_FILES += \
    external/boon-fonts/fonts.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/fonts.xml

$(foreach f, $(font_src_files), $(call build-one-font-module, $(f)))

build-one-font-module :=
font_src_files :=
