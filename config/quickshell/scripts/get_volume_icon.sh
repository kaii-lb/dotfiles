#!/bin/sh

volume=$(pamixer --get-volume)

icon="/home/kaii/.config/eww/assets/volume_mute.svg"

if [[ $volume -eq 0 ]]; then
	icon="/home/kaii/.config/eww/assets/volume_mute.svg"
elif [[ $volume -lt 33 ]]; then
	icon="/home/kaii/.config/eww/assets/volume_low.svg"
elif [[ $volume -lt 67 ]]; then
	icon="/home/kaii/.config/eww/assets/volume_mid.svg"
else
	icon="/home/kaii/.config/eww/assets/volume_high.svg"
fi

echo "{\"level\": \"${volume}\", \"icon\": \"${icon}\"}" >> /tmp/current_volume
