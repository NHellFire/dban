#!/bin/sh
while :; do printf .; sleep 300; done & pid=$!
trap "kill -TERM $pid" INT TERM EXIT
make
