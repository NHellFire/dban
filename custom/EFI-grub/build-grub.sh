#!/bin/sh
set -e
DIR="$(readlink -f .)"

# Dependencies: xfonts-unifont

cd git
./autogen.sh

./configure --prefix="$DIR/grub-built" --with-platform=efi --enable-grub-mkfont

make -j`nproc`

make install

# Install font
make unicode.pf2
cp -v unicode.pf2 ../
