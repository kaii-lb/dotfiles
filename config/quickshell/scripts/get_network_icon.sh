#!/bin/sh

active_network_type=$(nmcli -f TYPE connection show --active | sed "/loopback/d" | tr -d ' ' | tail -n1)
wifi_active=$(nmcli radio wifi)
connectivity=$(nmcli networking connectivity)

if [ $connectivity == "limited" ] || [ $connectivity == "unknown" ]; then
	echo "/home/kaii/.config/quickshell/assets/wifi_not_connected.svg"
	exit 0
fi

if [[ "${active_network_type}" == "wifi" ]] || [[ "${active_network_type}" == "bridge" ]]; then
	echo "/home/kaii/.config/quickshell/assets/wifi_connected.svg"
elif [[ "${active_network_type}" == "ethernet" ]]; then
	echo "/home/kaii/.config/quickshell/assets/ethernet.svg"
elif [[ "${wifi_active}" == "enabled" ]]; then
	echo "/home/kaii/.config/quickshell/assets/wifi_no_internet.svg"
elif [[ "${wifi_active}" == "disabled" ]]; then
	echo "/home/kaii/.config/quickshell/assets/wifi_off.svg"
fi
