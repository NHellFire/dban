#!/bin/sh

# sdX.result
#	DWIPE_METHOD
#	DWIPE_ROUNDS
#	DWIPE_VERIFY
#	DWIPE_RESULT

# sdX.env
#	LSHW_DESCRIPTION
#	LSHW_VENDOR
#	LSHW_PRODUCT
#	LSHW_VERSION
#	LSHW_SIZE
#	LSHW_SERIAL

# /tmp/datestamp
#	DATE_RFC2822=$(date -R)

. /tmp/datestamp

find /dev -type f -name '*.result' | while read result; do
	device="${result%.result}"

	# Clear variables for reuse.
	DWIPE_METHOD=error
	DWIPE_ROUNDS=error
	DWIPE_RESULT=error
	DWIPE_VERIFY=error
	LSHW_PRODUCT=error
	LSHW_SERIAL=error

	. "$result"
	. "$device.env"

	if [ "$DWIPE_FINGERPRINT" != "1" ]; then
		exit
	fi

	if [ "$DWIPE_RESULT" = "error" ]; then
		echo "Failed reading results file for $device"
		continue
	elif [ "$DWIPE_RESULT" != "skipped" ]; then
		sed	\
			-e "s!#MODEL#!$LSHW_PRODUCT!" \
			-e "s!#SERIAL#!$LSHW_SERIAL!" \
			-e "s!#DATE#!$DATE_RFC2822!" \
			-e "s!#RESULT#!$DWIPE_RESULT!" \
			-e "s!#METHOD#!$DWIPE_METHOD!" \
			/usr/local/share/dban/mbr.asm > "$device.asm"
			yasm "$device.asm" -o "$device.bin"
			dd if="$device.bin" of="$device" bs=512
			sync
	fi
done

