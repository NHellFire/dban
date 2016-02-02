ARCH ?= i586 ppc

all: $(ARCH)

$(ARCH):
	@echo Building $@
	make -C buildroot clean
	make -C buildroot dban_$@_defconfig
	make -C buildroot -j8
	./master.sh

clean:
	make -C buildroot clean

.PHONY: clean
