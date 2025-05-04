#!/bin/sh

out=$(cat /sys/devices/platform/INTC1041:00/odvp1)

if [[ $out == 0 ]]; then
	notify-send "LOQ is in balanced mode" "Intelligent thermal cooling"
elif [[ $out == 1 ]]; then
	notify-send "LOQ is in performance mode" "RIP your ears and battery"
else
	notify-send "LOQ is in quiet mode" "Silent running for fans"
fi
