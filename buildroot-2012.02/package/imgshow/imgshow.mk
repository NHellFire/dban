#############################################################
#
# imgshow
#
#############################################################
IMGSHOW_VERSION = 1.0.0
IMGSHOW_SOURCE = imgshow-$(IMGSHOW_VERSION).tar.gz
IMGSHOW_SITE = http://
IMGSHOW_INSTALL_STAGING = YES
IMGSHOW_INSTALL_TARGET = YES
IMGSHOW_CONF_OPT =
IMGSHOW_DEPENDENCIES = uclibc jpeg
IMGSHOW_DIR:=$(BUILD_DIR)/imgshow-$(IMGSHOW_VERSION)
IMGSHOW_BINARY:=imgshow
IMGSHOW_TARGET_BINARY:=usr/bin/imgshow
IMGSHOW_CAT:= $(ZCAT)

$(DL_DIR)/$(IMGSHOW_SOURCE):
	# $(WGET) -P $(DL_DIR) $(IMGSHOW_SITE)/$(IMGSHOW_SOURCE)

imgshow-source: $(DL_DIR)/$(IMGSHOW_SOURCE)

$(IMGSHOW_DIR)/.unpacked: $(DL_DIR)/$(IMGSHOW_SOURCE)
	$(IMGSHOW_CAT) $(DL_DIR)/$(IMGSHOW_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
	touch $(IMGSHOW_DIR)/.unpacked

$(IMGSHOW_DIR)/.configured: $(IMGSHOW_DIR)/.unpacked
	touch $@

$(IMGSHOW_DIR)/$(IMGSHOW_BINARY): $(IMGSHOW_DIR)/.configured
#$(IMGSHOW_DIR)/$(IMGSHOW_BINARY): $(IMGSHOW_DIR)/.unpacked
	$(MAKE) -C $(IMGSHOW_DIR) GCC="$(TARGET_CC)"
	$(STRIPCMD) $(IMGSHOW_DIR)/$(IMGSHOW_BINARY)

$(TARGET_DIR)/$(IMGSHOW_TARGET_BINARY): $(IMGSHOW_DIR)/$(IMGSHOW_BINARY)
#	$(INSTALL) -D $(IMGSHOW_DIR)/$(IMGSHOW_BINARY) $@
#	$(INSTALL) -m 0755 -D $(IMGSHOW_DIR)/$(IMGSHOW_BINARY) $(TARGET_DIR)/$(IMGSHOW_TARGET_BINARY)
	$(MAKE) DESTDIR=$(TARGET_DIR) -C $(IMGSHOW_DIR) install GCC="$(TARGET_CC)"
	cp $(IMGSHOW_DIR)/dban-ad.jpg $(TARGET_DIR)/usr/share  
	$(STRIPCMD) $@

imgshow: uclibc jpeg $(TARGET_DIR)/$(IMGSHOW_TARGET_BINARY)

imgshow-clean:
	$(MAKE) -C $(IMGSHOW_DIR) clean

imgshow-dirclean:
	rm -rf $(IMGSHOW_DIR)

ifeq ($(BR2_PACKAGE_IMGSHOW),y)
TARGETS+=imgshow
endif
