#!/bin/bash

icon=$(sh /home/kaii/.config/eww/scripts/get_network_icon.sh)
name=$(nmcli -t -f NAME connection show --active | head -n1 | tr -d ' ')

if [[ $name == "lo" ]]; then
	name="Network"
fi

echo '{"name": "'"$name"'", "icon": "'"$icon"'"}'

ip monitor link | while read -r line; do
    icon=$(sh /home/kaii/.config/eww/scripts/get_network_icon.sh)
    name=$(nmcli -t -f NAME connection show --active | head -n1 | tr -d ' ')

    if [[ $name == "lo" ]]; then
    	name="Network"
    fi

    echo '{"name": "'"$name"'", "icon": "'"$icon"'"}'
done
