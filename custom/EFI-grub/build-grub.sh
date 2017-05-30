#!/bin/sh
set -e
DIR="$(readlink -f .)"

cd git
./autogen.sh

./configure --prefix="$DIR/grub-built" --with-platform=efi

make -j`nproc`

make install
