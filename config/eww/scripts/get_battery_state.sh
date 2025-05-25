#!/bin/sh

battery_level=$(upower -d | grep percentage | head -n1 | tr -d '['', 'percentage:', '%']')
icon_number=$(printf %.0f\\n $(echo "scale=2; ($battery_level + 0.5) / 12.5" | bc -l))

echo '{"level": "'"$battery_level"'", "icon": "'"/home/${USER}/.config/eww/assets/battery-${icon_number}.svg"'"}'

upower -m | while read -r line; do
	upower_out=$(upower -d)

	state=$(echo "${upower_out}" | grep state | head -n1 | sed "s/state://" | tr -d ' ')
	battery_level=$(echo "${upower_out}" | grep percentage | head -n1 | tr -d '['', 'percentage:', '%']')
	icon_number=$(printf %.0f\\n $(echo "scale=2; ($battery_level + 0.5) / 12.5" | bc -l))

	echo '{"level": "'"$battery_level"'", "icon": "'"/home/${USER}/.config/eww/assets/battery-${icon_number}.svg"'", "state": "'"$state"'"}'
done
