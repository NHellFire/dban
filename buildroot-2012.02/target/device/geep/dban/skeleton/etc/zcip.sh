#!/bin/bash

test -z "$interface" && exit 1

case "$1" in

	init)
		/sbin/ifconfig $interface up
		exit 0
		;;

	config)
		test -z "$ip" && exit 1
		/sbin/ifconfig $interface $ip netmask 255.255.0.0
		exit 0
		;;

	deconfig)
		test -z "$ip" && exit 1
		/sbin/ifconfig $interface down
		exit 0
		;;

esac
exit 1
