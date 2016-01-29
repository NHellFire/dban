all: dban


dban: clean
	make -C buildroot dban_i586_defconfig
	make -C buildroot -j8
	./master.sh


clean:
	make -C buildroot clean


.PHONY: all dban clean




# Comments
ifeq ("a", "b")
# This will be useful when/if we add more platforms
ARCH ?= i586 powerpc

all: $(ARCH)

$(ARCH):
	@echo Building $@

endif
