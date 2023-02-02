#!/bin/bash

SCRIPTS_DIR=~/.local/bin/

get_battery_status() {
    device_uuid=$1
    device_uuid_slug=$(echo "$device_uuid" | sed 's/:/_/g')
    device_upower_path=$(upower -e | grep "$device_uuid_slug")
    if [[ "$?" != 0 ]]; then
        return 1
    fi

    upower_out=$(upower -i "$device_upower_path")
    percentage=$(echo "$upower_out" | grep 'percentage:' | grep -oe '[0-9]*%')
    if [[ "$?" != 0 ]]; then
        return 1
    fi

    echo $percentage
}

# prepare devices to process
connected_devices=$1
if [[ "$connected_devices" == "" ]]; then
    connected_devices=$($SCRIPTS_DIR/connected_bluetooth_devices.sh)
fi
if [[ "$connected_devices" == "" ]]; then
    echo "no bluetooth devices connected" >&2
    exit 1
fi

n=0
declare -A device_batteries
for device in ${connected_devices//\\n/ }; do
    device_battery_percentage=$(get_battery_status "$device")
    if [[ $? != 0 ]]; then
        continue
    fi

    n=$((n+1))
    device_batteries[$device]=$device_battery_percentage
    # echo "$device: $device_battery_percentage"
done

if [[ $n -eq 0 ]]; then
    echo "cannot get battery status for any specified bluetooth device" >&2
    exit 1
fi

# TODO: do something else?
for device in ${!device_batteries[*]}; do
    echo "$device ${device_batteries[$device]}"
done
