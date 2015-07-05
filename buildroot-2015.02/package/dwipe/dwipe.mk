DWIPE_VERSION = 758b84925ff54cef4d95893abf9736d560385878
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
