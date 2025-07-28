#!/bin/bash

icon=$(sh /home/kaii/.config/quickshell/scripts/get_network_icon.sh)
info=$(nmcli -t -f NAME connection show --active | head -n1 | tr -d ' ')
name=$(echo $info | cut -d: -f1)
powered=$(nmcli radio wifi)

if [[ $name == "lo" ]]; then
	name="Network"
fi

state="Disconnected"

if [[ $icon == *"wifi_connected.svg" ]]; then
	state="Connected"
elif [[ $powered == "disabled" ]]; then
	state="Powered Off"
fi

echo "{\"name\": \"${name}\", \"icon\": \"${icon}\", \"state\": \"${state}\"}"

ip monitor link | while read -r line; do
    icon=$(sh /home/kaii/.config/quickshell/scripts/get_network_icon.sh)
    info=$(nmcli -t -f NAME connection show --active | head -n1 | tr -d ' ')
    name=$(echo $info | cut -d: -f1)
    powered=$(nmcli radio wifi)

    if [[ $name == "lo" ]]; then
    	name="Network"
    fi

    state="Disconnected"

    if [[ $icon == *"wifi_connected.svg" ]]; then
    	state="Connected"
   	elif [[ $powered == "disabled" ]]; then
   		state="Powered Off"
   	fi

	echo "{\"name\": \"${name}\", \"icon\": \"${icon}\", \"state\": \"${state}\"}"
done
