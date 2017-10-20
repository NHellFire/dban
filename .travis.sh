#!/bin/sh
logfile=$(mktemp)
while :; do printf .; sleep 30; done & pid=$!
trap "cleanup" INT TERM EXIT
cleanup() {
	kill -TERM $pid
	tail -n 500 "$logfile"
	rm -f "$logfile"
}

make > "$logfile" 2>&1
