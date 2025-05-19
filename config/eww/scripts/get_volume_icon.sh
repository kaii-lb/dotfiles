#!/bin/sh

volume=$(pamixer --get-volume)

if [[ $volume -eq 0 ]]; then
	echo "/home/kaii/.config/eww/assets/volume_mute.svg" >> /tmp/current_volume
elif [[ $volume -lt 33 ]]; then
	echo "/home/kaii/.config/eww/assets/volume_low.svg" >> /tmp/current_volume
elif [[ $volume -lt 67 ]]; then
	echo "/home/kaii/.config/eww/assets/volume_mid.svg" >> /tmp/current_volume
else
	echo "/home/kaii/.config/eww/assets/volume_high.svg" >> /tmp/current_volume
fi
