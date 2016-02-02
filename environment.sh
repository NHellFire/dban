#!/bin/bash
if [ "$0" = "$BASH_SOURCE" ]; then
	echo "Do not run this script directly."
	echo "Use: source environment.sh"
	exit 1
fi

TOP="$(dirname "$BASH_SOURCE")"
BR2_CONFIG="$TOP/buildroot/.config"
test ! -s "$BR2_CONFIG" && echo "$BASH_SOURCE: $BR2_CONFIG is missing." && return 1

eval $(grep -E '^BR2_(ARCH|GCC_TARGET_(ARCH|CPU))=' "$BR2_CONFIG")
ARCH=$BR2_ARCH
[ -z "$BR2_GCC_TARGET_ARCH" ] && BR2_GCC_TARGET_ARCH=$BR2_GCC_TARGET_CPU

TOOLCHAIN_PREFIX=$(readlink -e "$TOP/buildroot/output/host")
PATH="$TOOLCHAIN_PREFIX/usr/bin:$PATH"

export HOST="$ARCH-buildroot-linux-uclibc"

CC="$ARCH-buildroot-linux-uclibc-gcc"
"$CC" --version >/dev/null || { echo "$BASH_SOURCE: $CC is not executable."; return 2; }

CXX="$ARCH-buildroot-linux-uclibc-g++"
"$CXX" --version >/dev/null || { echo "$BASH_SOURCE: $CXX is not executable."; return 3; }

STRIP="$ARCH-buildroot-linux-uclibc-strip"
"$STRIP" --version >/dev/null || { echo "$BASH_SOURCE: $STRIP is not executable."; return 4; }

CFLAGS="-Os -pipe -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -mtune=$BR2_GCC_TARGET_ARCH"
CXXFLAGS=$CFLAGS

PS1="(buildroot) $PS1"

export CC CXX STRIP
export CFLAGS CXXFLAGS
export PATH PS1 TOOLCHAIN_PREFIX
export BR2_ARCH
