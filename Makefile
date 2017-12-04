ARCHLIST := $(patsubst buildroot/configs/dban_%_defconfig,%,$(wildcard buildroot/configs/dban_*_defconfig))
ARCH ?= $(ARCHLIST)

all: $(ARCH)

$(ARCHLIST):
	@echo Building $@
	make -C buildroot clean
	make -C buildroot dban_$@_defconfig
	make -C buildroot -j8
	./master.sh

clean:
	make -C buildroot clean

help:
	@echo Available architectures: $(ARCHLIST)

.PHONY: clean help

.NOTPARALLEL:
