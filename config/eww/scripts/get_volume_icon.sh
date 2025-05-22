#!/bin/sh

volume=$(pamixer --get-volume)

echo $volume >> /tmp/current_volume

if [[ $volume -eq 0 ]]; then
	echo "/home/kaii/.config/eww/assets/volume_mute.svg" >> /tmp/current_volume_icon
elif [[ $volume -lt 33 ]]; then
	echo "/home/kaii/.config/eww/assets/volume_low.svg" >> /tmp/current_volume_icon
elif [[ $volume -lt 67 ]]; then
	echo "/home/kaii/.config/eww/assets/volume_mid.svg" >> /tmp/current_volume_icon
else
	echo "/home/kaii/.config/eww/assets/volume_high.svg" >> /tmp/current_volume_icon
fi

brightness_open=$(eww get open_brightness_osd)

eww update open_brightness_osd=false
eww update open_volume_osd=true

sleep 3
eww_volume=$(eww get volume)
if [[ $eww_volume -eq $volume ]]; then
	eww update open_volume_osd=false
fi
