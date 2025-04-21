#!/bin/sh

out=$(cat /sys/devices/platform/INTC1041:00/odvp1)

if [[ $out == 2 ]]; then
	notify-send "GPU set to power saving mode"
else
	notify-send "GPU set to performance mode"
fi
