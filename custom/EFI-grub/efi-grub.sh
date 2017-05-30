#!/bin/sh
set -e

PATH="./grub-built/bin:$PATH"

MODULES="normal"
MODULES="$MODULES part_gpt part_msdos" # Partition tables
MODULES="$MODULES fat ntfs exfat iso9660" # Filesystems
MODULES="$MODULES linux chain" # Boot targets
MODULES="$MODULES help reboot halt" # Utilities
MODULES="$MODULES ls search search_fs_file" # Utilities
MODULES="$MODULES usb_keyboard at_keyboard all_video" # Hardware support
MODULES="$MODULES configfile sleep" # TEMP - Debugging

grub-mkimage --format=x86_64-efi --output=BOOTX64.EFI --config=embed.cfg --prefix=/EFI/BOOT $MODULES

sizeMB=$(set -- $(du -m BOOTX64.EFI); echo $1)

dd if=/dev/zero of=efiboot.img bs=1M count=$sizeMB

mkdosfs -F 12 efiboot.img

mkdir -p efiboot
sudo mount -o loop efiboot.img efiboot

sudo mkdir -p efiboot/EFI/BOOT

sudo cp BOOTX64.EFI efiboot/EFI/BOOT/

sudo umount efiboot
