#!/bin/bash

# Set environment variables to use the buildroot cross compiler for this target architecture.
ARCH=${ARCH:=i586}

# ...

test ! -d $(readlink -e ./buildroot) && echo "$0: Incorrect working directory." && exit 1

STAGING_PREFIX=$(readlink -e ./buildroot/output/staging)
PATH="$STAGING_PREFIX/bin:$STAGING_PREFIX/usr/bin:$PATH"

CC="$ARCH-linux-uclibc-gcc"
"$CC" --version >/dev/null || { echo "$0: $CC is not executable."; exit 2; }

CXX="$ARCH-linux-uclibc-g++"
"$CXX" --version >/dev/null || { echo "$0: $CXX is not executable."; exit 3; }

STRIP="$ARCH-linux-uclibc-strip"
"$STRIP" --version >/dev/null || { echo "$0: $STRIP is not executable."; exit 4; }

COMPILER_PARAMETERS="-Os -pipe -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -I$STAGING_PREFIX/usr/include -I$STAGING_PREFIX/include --sysroot=$STAGING_PREFIX/ -isysroot $STAGING_PREFIX -mtune=$ARCH -march=$ARCH"

CC="$CC $COMPILER_PARAMETERS"
CXX="$CXX $COMPILER_PARAMETERS"
PS1="$PS1 <buildroot> "

export CC CXX PATH PS1 STAGING_PREFIX STRIP
exec $0
