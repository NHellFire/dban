#!/bin/bash
set -e

. ../../environment.sh
if [ "$BR2_ARCH" != "powerpc" ]; then
	echo "buildroot is configured for the wrong architecture"
	echo "Must be powerpc, NOT $BR2_ARCH"
	exit 1
fi

cd e2fsprogs
make distclean || true
./configure --host=$HOST
make -j4 libs
cd ..

cd yaboot
make clean
make -j4 CROSS=$HOST-
cd ..

echo -e "\n\nyaboot built at:"

ls -ll yaboot/second/yaboot
