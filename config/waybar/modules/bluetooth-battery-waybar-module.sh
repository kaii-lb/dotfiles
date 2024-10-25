#!/bin/bash

ICON_BLUETOOTH=""
ICON_BATTERY_FULL=""
ICON_BATTERY_THREE_QUARTERS=""
ICON_BATTERY_HALF=""
ICON_BATTERY_QUARTER=""
ICON_BATTERY_EMPTY=""
BLUETOOTH_BATTERY_STATUS=$HOME/.local/bin/bluetooth_battery_status.sh

tooltip=""

statuses="$($BLUETOOTH_BATTERY_STATUS)"
if [[ $? != 0 ]]; then
    exit 1
fi


n=0
sum=0
IFS=$'\n'
for status in $statuses; do
    uuid=$(echo "$status" | cut -d' ' -f1)
    name=$(bluetoothctl info "$uuid" | grep -oe 'Name: .*' | awk 'match($0, "Name: (.*)", m){print m[1]}')
    percent=$(echo "$status" | cut -d' ' -f2 | grep -oe '[0-9]*')

	if [[ $name -eq P ]]; then
		name="Bluetooth Headphones"
	fi	

    tooltip="$tooltip$name: $percent%\n"

    n=$((n+1))
    sum=$((sum+percent))
done
IFS=' '

avg=$((sum / n))

ICON_BATTERY=""
if [[ $avg -ge 90 ]]; then
    ICON_BATTERY=$ICON_BATTERY_FULL
elif [[ $avg -ge 75 ]]; then
    ICON_BATTERY=$ICON_BATTERY_THREE_QUARTERS
elif [[ $avg -ge 50 ]]; then
    ICON_BATTERY=$ICON_BATTERY_HALF
elif [[ $avg -ge 25 ]]; then
    ICON_BATTERY=$ICON_BATTERY_QUARTER
else
    ICON_BATTERY=$ICON_BATTERY_EMPTY
fi

tooltip=${tooltip%\\n}

echo "{\"text\": \"$percent%\", \"tooltip\": \"$tooltip\"}"
