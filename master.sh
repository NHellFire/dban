#!/bin/bash

BR2_CONFIG=buildroot/.config

test ! -d $(readlink -e ./buildroot) && echo "$0: Incorrect working directory: ./buildroot/ is missing. " && exit 1
test ! -r "$BR2_CONFIG" && echo "$0: $BR2_CONFIG is missing." && exit 2

eval $(grep ^BR2_ROOTFS_ "$BR2_CONFIG")
eval $(grep ^BR2_GCC_TARGET_ "$BR2_CONFIG")
eval $(grep ^BR2_LINUX_KERNEL_VERSION "$BR2_CONFIG")
. dban.def

BR2_BZIMAGE="buildroot/output/images/bzImage"

test ! -r "$BR2_BZIMAGE" && echo "$0: $BR2_BZIMAGE is missing." && exit 3
test ! -r "isoroot/isolinux.bin" && echo "$0: isoroot/isolinux.bin is missing." && exit 4

cp -v "buildroot/output/images/bzImage" "isoroot/dban.bzi"

OUTNAME="dban-${DBAN_VERSION}_linux_${BR2_LINUX_KERNEL_VERSION}_${BR2_GCC_TARGET_ARCH}.iso"
#OUTNAME="dban-${DBAN_VERSION}_${BR2_GCC_TARGET_ARCH}.iso"

mkisofs -o "$OUTNAME" -b isolinux.bin -c isolinux.cat -no-emul-boot -boot-load-size 4 -boot-info-table -V DBAN isoroot/
ls -ll "$OUTNAME"
