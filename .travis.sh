#!/bin/sh
ARCH="$1"
if [ -z "$ARCH" ]; then
	echo "Usage: $0 <arch>"
	exit 1
fi

logfile=$(mktemp)
while :; do printf .; sleep 30; done & pid=$!
trap "cleanup" INT TERM EXIT
cleanup() {
	kill -TERM $pid
	printf "\n"
	tail -n 500 "$logfile"
	rm -f "$logfile"
}

make $ARCH > "$logfile" 2>&1
