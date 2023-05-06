#!/bin/bash


connected_device=$(~/.local/bin/connected_bluetooth_devices.sh | head -n1)

battery_level=$(bluetooth_battery $connected_device | cut -f6 -d" ")

if [[ -z $battery_level ]]; then
	echo ""
else
	echo "{\"text\": \"$battery_level\"}"
fi
