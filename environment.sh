#!/bin/bash
if [ "$0" = "$BASH_SOURCE" ]; then
	echo "Do not run this script directly."
	echo "Use: source environment.sh"
	exit 1
fi

BR2_CONFIG=buildroot/.config
test ! -s "$BR2_CONFIG" && echo "$BASH_SOURCE: $BR2_CONFIG is missing." && return 1

eval $(grep ^BR2_GCC_TARGET_ARCH "$BR2_CONFIG")
ARCH=$BR2_GCC_TARGET_ARCH


TOOLCHAIN_PREFIX=$(readlink -e ./buildroot/output/host)
PATH="$TOOLCHAIN_PREFIX/usr/bin:$PATH"

CC="$ARCH-buildroot-linux-uclibc-gcc"
"$CC" --version >/dev/null || { echo "$BASH_SOURCE: $CC is not executable."; return 2; }

CXX="$ARCH-buildroot-linux-uclibc-g++"
"$CXX" --version >/dev/null || { echo "$BASH_SOURCE: $CXX is not executable."; return 3; }

STRIP="$ARCH-buildroot-linux-uclibc-strip"
"$STRIP" --version >/dev/null || { echo "$BASH_SOURCE: $STRIP is not executable."; return 4; }

CFLAGS="-Os -pipe -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -mtune=$ARCH -march=$ARCH"
CXXFLAGS=$CFLAGS

PS1="(buildroot) $PS1"

export CC CXX STRIP
export CFLAGS CXXFLAGS
export PATH PS1 TOOLCHAIN_PREFIX
