#!/bin/sh

active_network_type=$(nmcli -f TYPE connection show --active | sed "/loopback/d" | tr -d ' ' | tail -n1)
wifi_active=$(nmcli radio wifi)
connectivity=$(nmcli networking connectivity)

if [ $connectivity == "limited" ] || [ $connectivity == "unknown" ]; then
	echo "/home/kaii/.config/eww/assets/wifi_not_connected.svg"
	exit 0
fi

if [[ "${active_network_type}" -eq "wifi" ]]; then
	echo "/home/kaii/.config/eww/assets/wifi_connected.svg"
elif [[ "${active_network_type}" -eq "ethernet" ]]; then
	echo "/home/kaii/.config/eww/assets/ethernet.svg"
elif [[ "${wifi_active}" -eq "enabled" ]]; then
	echo "/home/kaii/.config/eww/assets/wifi_no_internet.svg"
elif [[ "${wifi_active}" -eq "disabled" ]]; then
	echo "/home/kaii/.config/eww/assets/wifi_off.svg"
fi
