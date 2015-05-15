#!/bin/sh
TARGET_DIR="$1"

# We don't want to use "predictable" interface names
rm -f "$TARGET_DIR/lib/udev/rules.d/80-net-name-slot.rules"
