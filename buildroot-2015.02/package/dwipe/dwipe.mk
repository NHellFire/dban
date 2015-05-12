DWIPE_VERSION = 9a3064837a57752424e4a31624fe876e5f18fbc7
DWIPE_SOURCE = dwipe-$(DWIPE_VERSION).tar.gz
DWIPE_SITE = git://github.com/NHellFire/dwipe.git
DWIPE_DEPENDENCIES = uclibc ncurses
DWIPE_BINARY = dwipe

define DWIPE_BUILD_CMDS
	$(MAKE) GCC="$(TARGET_CC)" CC="$(TARGET_CC)" STRIP="$(TARGET_STRIP)" -C $(@D) all
endef

define DWIPE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/$(DWIPE_BINARY) $(TARGET_DIR)/usr/local/bin/
endef
	

$(eval $(generic-package))
