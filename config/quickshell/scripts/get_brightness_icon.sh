#!/bin/sh

brightness=$(brightnessctl i | grep Current | cut -f4 -d' ' | sed -e "s/(//g" -e "s/%)//g")
icon="/home/kaii/.config/quickshell/assets/brightness_1.svg"

if [[ $brightness -lt 20 ]]; then
	icon="/home/kaii/.config/quickshell/assets/brightness_1.svg"
elif [[ $brightness -lt 40 ]]; then
	icon="/home/kaii/.config/quickshell/assets/brightness_2.svg"
elif [[ $brightness -lt 60 ]]; then
	icon="/home/kaii/.config/quickshell/assets/brightness_3.svg"
elif [[ $brightness -lt 80 ]]; then
	icon="/home/kaii/.config/quickshell/assets/brightness_4.svg"
else
	icon="/home/kaii/.config/quickshell/assets/brightness_5.svg"
fi

echo "{\"level\": \"${brightness}\", \"icon\": \"${icon}\"}" >> /tmp/current_brightness
