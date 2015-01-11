#############################################################
#
# dwipe
#
#############################################################
DWIPE_VERSION:=2.1.0
DWIPE_SOURCE:=dwipe-$(DWIPE_VERSION).tar.gz
DWIPE_SITE:=http://
DWIPE_INSTALL_STAGING = YES
DWIPE_INSTALL_TARGET = YES
DWIPE_CONF_OPT =
DWIPE_DEPENDENCIES = uclibc
DWIPE_DIR:=$(BUILD_DIR)/dwipe-$(DWIPE_VERSION)
DWIPE_BINARY:=dwipe
DWIPE_TARGET_BINARY:=usr/local/bin/dwipe
DWIPE_CAT:= $(ZCAT)

$(DL_DIR)/$(DWIPE_SOURCE):
	# $(WGET) -P $(DL_DIR) $(DWIPE_SITE)/$(DWIPE_SOURCE)

dwipe-source: $(DL_DIR)/$(DWIPE_SOURCE)

$(DWIPE_DIR)/.unpacked: $(DL_DIR)/$(DWIPE_SOURCE)
	#cp -r dwipe-2.1.0 $(DWIPE_DIR)
	$(DWIPE_CAT) $(DL_DIR)/$(DWIPE_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -	
	touch $(DWIPE_DIR)/.unpacked

$(DWIPE_DIR)/.configured: $(DWIPE_DIR)/.unpacked
	touch $@	
	
#$(DWIPE_DIR)/$(DWIPE_BINARY): $(DWIPE_DIR)/.configured
$(DWIPE_DIR)/$(DWIPE_BINARY): $(DWIPE_DIR)/.unpacked
	$(MAKE) -C $(DWIPE_DIR) GCC="$(TARGET_CC)"
	$(STRIPCMD) $(DWIPE_DIR)/$(DWIPE_BINARY)
	
$(TARGET_DIR)/$(DWIPE_TARGET_BINARY): $(DWIPE_DIR)/$(DWIPE_BINARY)
	$(INSTALL) -m 0755 -D $(DWIPE_DIR)/$(DWIPE_BINARY) $(TARGET_DIR)/$(DWIPE_TARGET_BINARY)
	#$(MAKE) DESTDIR=$(TARGET_DIR) -C $(DWIPE_DIR) install GCC="$(TARGET_CC)"
	
dwipe: uclibc $(TARGET_DIR)/$(DWIPE_TARGET_BINARY)

dwipe-clean:
	rm -f $(TARGET_DIR)/$(DWIPE_TARGET_BINARY)
	-$(MAKE) -C $(DWIPE_DIR) clean

dwipe-dirclean:
	rm -rf $(DWIPE_DIR)

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(strip $(BR2_PACKAGE_DWIPE)),y)
TARGETS+=dwipe
endif
