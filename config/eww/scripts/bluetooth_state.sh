#!/bin/sh

props=$(bluetoothctl show)

powered=$(echo "${props}" | grep Powered | sed 's/Powered: //' | tr -d '["\t", " "]')

info=$(bluetoothctl info)
connected_device=$(echo "${info}" | grep Name | sed 's/Name: //' | tr -d '\t')
battery=$(echo "${info}" | grep Battery | sed 's/Battery Percentage://' | tr -d "['\t', ')']" | cut -f2 -d'(')

icon="/home/kaii/.config/eww/assets/bluetooth_off.svg"

if [[ $powered == "yes" ]] && [[ $connected_device != "" ]]; then
	icon="/home/kaii/.config/eww/assets/bluetooth_connected.svg"
elif [[ $powered == "yes" ]]; then
	icon="/home/kaii/.config/eww/assets/bluetooth_on.svg"
else
	icon="/home/kaii/.config/eww/assets/bluetooth_off.svg"
fi

if [[ $powered == "yes" ]];then
	powered=true
else
	powered=false
fi

echo '{"powered": "'"$powered"'", "connected_device": "'"$connected_device"'", "battery": "'"$battery"'", "icon": "'"$icon"'"}'
