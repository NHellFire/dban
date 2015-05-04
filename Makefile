all: dban


dban: clean
	make -C buildroot dban_defconfig
	make -C buildroot -j8
	./master.sh


clean:
	make -C buildroot clean


.PHONY: all dban clean
